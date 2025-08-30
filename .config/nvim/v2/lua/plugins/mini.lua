return {
  'nvim-mini/mini.nvim',
  version = '*',
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    ai = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
          d = { "%f[%d]%d+" },                                                          -- digits
          e = {                                                                         -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    pairs = {
      modes = { insert = true, command = true, terminal = false }
    },
    files = {
      options = {
        -- use trash stored at mini.files/trash
        permanent_delete = false
      }
    },
    comment = {},
    move = {},
    splitjoin = {},
    surround = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      }
    },
    bracketed = {},
    diff = {
      view = {
        style = 'sign',
        signs = {
          add = "▎",
          change = "▎",
          delete = ""
        }
      },
    },
    icons = {},
    pick = {},
    notify = {
      lsp_progress = {
        enable = false
      }
    },
    git = {},
    extra = {}
  },
  config = function(_, opts)
    require("mini.ai").setup(opts.ai())
    require("mini.pairs").setup(opts.pairs)
    require('mini.files').setup(opts.files)
    require("mini.comment").setup(opts.comment)
    require("mini.move").setup(opts.move)
    require("mini.splitjoin").setup(opts.splitjoin)
    require("mini.surround").setup(opts.surround)
    require("mini.bracketed").setup(opts.bracketed)
    require("mini.icons").setup(opts.icons)
    require("mini.pick").setup(opts.pick)
    require("mini.notify").setup(opts.notify)
    require("mini.diff").setup(opts.diff)
    require("mini.git").setup(opts.git)
    require("mini.extra").setup(opts.extra)

    vim.notify = require('mini.notify').make_notify()

    local minifiles_toggle = function(...)
      if not MiniFiles.close() then MiniFiles.open(...) end
    end

    vim.keymap.set({ 'n', 'v' }, '<leader>e', function() minifiles_toggle(vim.api.nvim_buf_get_name(0), true) end,
      { desc = "Open mini.files (directory of current file)" })
    vim.keymap.set({ 'n', 'v' }, '<leader>E', function() minifiles_toggle(vim.uv.cwd(), true) end,
      { desc = "Open mini.files (cwd)" })
    vim.keymap.set({ "n", "v" }, "<leader>sf", function() MiniPick.builtin.files() end, { desc = "Search files" })
    vim.keymap.set({ "n", "v" }, "<leader>sg", function() MiniPick.builtin.grep_live() end, { desc = "Live grep" })
    vim.keymap.set({ "n", "v" }, "<leader>sb", function() MiniPick.builtin.buffers() end, { desc = "Search buffers" })
    vim.keymap.set({ "n", "v" }, "<leader>sr", function() MiniPick.builtin.resume() end, { desc = "Resume last search" })
    vim.keymap.set({ "n", "v" }, "<leader>sk", function() MiniExtra.pickers.keymaps() end, { desc = "Search keymaps" })

    vim.keymap.set({ "n", "v" }, "<leader>ss", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,
      { desc = "Search lsp document symbols" })
    vim.keymap.set({ "n", "v" }, "<leader>sS", function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end,
      { desc = "Search lsp workspace symbols" })
    vim.keymap.set({ "n", "v" }, "<leader>grr", function() MiniExtra.pickers.lsp({ scope = 'references' }) end,
      { desc = "Search references" })
    vim.keymap.set({ "n", "v" }, "<leader>gd", function() MiniExtra.pickers.lsp({ scope = 'definition' }) end,
      { desc = "Search definition" })
    vim.keymap.set({ "n", "v" }, "<leader>gD", function() MiniExtra.pickers.lsp({ scope = 'declaration' }) end,
      { desc = "Search declaration" })
    vim.keymap.set({ "n", "v" }, "<leader>gri", function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end,
      { desc = "Search implementation" })
    vim.keymap.set({ "n", "v" }, "<leader>grt", function() MiniExtra.pickers.lsp({ scope = 'type_definition' }) end,
      { desc = "Search type definition" })

    vim.keymap.set({ "n", "v" }, "<leader>xx", function() MiniExtra.pickers.diagnostic({ scope = 'current' }) end,
      { desc = "Search diagnostics (current buffer)" })
    vim.keymap.set({ "n", "v" }, "<leader>xX", function() MiniExtra.pickers.diagnostic({ scope = 'all' }) end,
      { desc = "Search diagnostics" })

    vim.keymap.set({ 'n', 'x' }, '<Leader>gs', function() MiniGit.show_at_cursor() end, { desc = 'Show at cursor' })

    vim.keymap.set({ "n", "v" }, "<leader>n", function() MiniNotify.show_history() end,
      { desc = "Show notification history" })
  end
}
