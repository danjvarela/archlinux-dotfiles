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
      org_agenda_custom_commands = {
        w = {
          description = "Work Agenda",
          types = {
            {
              type = "agenda",
              org_agenda_files = { "~/.orgfiles/work/**/*" },
            },
          },
        },
        p = {
          description = "Personal Agenda",
          types = {
            {
              type = "agenda",
              org_agenda_files = { "~/.orgfiles/personal/**/*" },
            },
          },
        },
      },
      notifications = {
        enabled = true,
        reminder_time = { 0, 5, 10 },
        notifier = function(tasks)
          local result = {}
          for _, task in ipairs(tasks) do
            require("orgmode.utils").concat(result, {
              string.format("# %s (%s)", task.category, task.humanized_duration),
              string.format("%s %s %s", string.rep("*", task.level), task.todo, task.title),
              string.format("%s: <%s>", task.type, task.time:to_string()),
            })
          end

          -- Example: if you use Snacks, you can do something like this (THis is not implemented)
          Snacks.notifier.notify(table.concat(result, "\n"), vim.log.levels.INFO, {
            title = "Orgmode",
          })
        end,
      },
    })
    require("org-bullets").setup()
  end,
}
