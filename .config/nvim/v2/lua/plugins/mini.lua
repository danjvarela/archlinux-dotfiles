return {
  'nvim-mini/mini.nvim',
  version = '*',
  opts = {
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

    vim.keymap.set({'n','v'}, '<leader>e', function() minifiles_toggle(vim.api.nvim_buf_get_name(0), true) end, {desc = "Open mini.files (directory of current file)"})
    vim.keymap.set({'n','v'}, '<leader>E', function() minifiles_toggle(vim.uv.cwd(), true) end, {desc = "Open mini.files (cwd)"})
  end
}
