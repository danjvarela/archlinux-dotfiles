return {
  "snacks.nvim",
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    image = { enabled = true },
    scroll = { enabled = false },
    picker = {
      matcher = {
        cwd_bonus = true, -- give bonus for matching files in the cwd
        frecency = true, -- give bonus for frequent and recently visited files
      },
    },
  },
}
