-- Function to copy relative path to clipboard
local function copy_relative_path()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end

  -- Get LSP root directory
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local root = nil

  if #clients > 0 then
    -- Use the root from the first active LSP client
    root = clients[1].config.root_dir
  end

  -- Fallback to vim.fs.find if no LSP root found
  if not root then
    local markers = { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "Makefile" }
    local found = vim.fs.find(markers, {
      path = filepath,
      upward = true,
      type = "file",
    })
    if #found > 0 then
      root = vim.fs.dirname(found[1])
    else
      root = vim.fn.getcwd()
    end
  end

  -- Get relative path
  local relative_path = vim.fn.fnamemodify(filepath, ":.")
  if root and root ~= vim.fn.getcwd() then
    relative_path = string.gsub(filepath, "^" .. vim.pesc(root) .. "/", "")
  end

  -- Copy to clipboard
  vim.fn.setreg("+", relative_path)
  vim.notify("Copied: " .. relative_path, vim.log.levels.INFO)
end

-- Function to copy absolute path to clipboard
local function copy_absolute_path()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end

  -- Copy to clipboard
  vim.fn.setreg("+", filepath)
  vim.notify("Copied: " .. filepath, vim.log.levels.INFO)
end

-- Create the commands
vim.api.nvim_create_user_command("CopyRelativePath", copy_relative_path, {
  desc = "Copy current buffer path relative to project root",
})

vim.api.nvim_create_user_command("CopyAbsolutePath", copy_absolute_path, {
  desc = "Copy current buffer absolute path",
})

-------------------------------------------------------------------------------------

local function delete_file_and_buffer()
  local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(vim.fn.expand("%"))
    vim.api.nvim_buf_delete(0, { force = true })
  end
end

vim.api.nvim_create_user_command("DeleteFileAndBuffer", delete_file_and_buffer, {
  desc = "Delete file in the currently opened buffer. Deletes buffer as well.",
})
