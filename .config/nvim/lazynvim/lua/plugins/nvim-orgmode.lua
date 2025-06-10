return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "akinsho/org-bullets.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("orgmode").setup({
      org_agenda_files = "~/.orgfiles/**/*.org",
      org_default_notes_file = "~/.orgfiles/refile.org",
      org_todo_keywords = {
        "TODO",
        "ONGOING",
        "HOLD",
        "WAITING",
        "|",
        "DONE",
        "CANCELLED",
      },
      org_todo_keyword_faces = {
        TODO = ":foreground red :weight bold",
        ONGOING = ":foreground yellow :weight bold",
        WAITING = ":foreground orange :weight bold",
        HOLD = ":foreground magenta :weight bold",
        DONE = ":foreground green :weight bold",
        CANCELLED = ":foreground grey :weight bold",
      },
      ui = {
        input = {
          use_vim_ui = true,
        },
      },
    })
    require("org-bullets").setup()
  end,
}
