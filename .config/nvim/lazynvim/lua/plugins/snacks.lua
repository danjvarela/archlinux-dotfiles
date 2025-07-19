return {
  "snacks.nvim",
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    image = { enabled = false },
    scroll = { enabled = false },
    picker = {
      matcher = {
        frecency = true, -- give bonus for frequent and recently visited files
        history_bonus = true, -- give more weight to chronological order
      },
      sources = {
        explorer = {
          auto_close = true,
        },
      },
    },
    explorer = {
      replace_netrw = true,
    },
  },
}
