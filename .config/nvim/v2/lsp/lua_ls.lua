return {
  cmd = {
    vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "lua-language-server")
  },
  filetypes = { "lua" },
  root_markers = {
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
          vim.fn.stdpath('data') .. '/lazy'
        }
      }
    }
  }
}
