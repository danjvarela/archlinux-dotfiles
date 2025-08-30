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
      -- use trash stored at mini.files/trash
      permanent_delete = false
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
    bracketed = {
      quickfix = {
        suffix = '' -- Trouble plugin already handles this mapping
      }
    },
    diff = {
      view = {
        style = 'sign'
      }
    },
    icons = {},
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

    local minifiles_toggle = function(...)
      if not MiniFiles.close() then MiniFiles.open(...) end
    end

    vim.keymap.set({ 'n', 'v' }, '<leader>e', function() minifiles_toggle(vim.api.nvim_buf_get_name(0), true) end,
      { desc = "Open mini.files (directory of current file)" })
    vim.keymap.set({ 'n', 'v' }, '<leader>E', function() minifiles_toggle(vim.uv.cwd(), true) end,
      { desc = "Open mini.files (cwd)" })
  end
}
