local personal_agenda_orgfiles_path = "~/Documents/notes/personal/life/**/*"
local work_agenda_orgfiles_path = "~/Documents/notes/work/**/*"

return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "akinsho/org-bullets.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("orgmode").setup({
      org_agenda_files = { personal_agenda_orgfiles_path, work_agenda_orgfiles_path, "~/Documents/notes/*" },
      org_default_notes_file = "~/Documents/notes/refile.org",
      org_todo_keywords = {
        "TODO(t)",
        "ONGOING(o)",
        "HOLD(h)",
        "WAITING(w)",
        "|",
        "DONE(d)",
        "CANCELLED(c)",
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
              org_agenda_files = { work_agenda_orgfiles_path },
            },
          },
        },
        p = {
          description = "Personal Agenda",
          types = {
            {
              type = "agenda",
              org_agenda_files = { personal_agenda_orgfiles_path },
              org_agenda_tag_filter_preset = "-USHolidays",
            },
          },
        },
      },
      org_log_done = "time",
      org_log_repeat = "time",
      org_log_into_drawer = "LOGBOOK", -- creates a LOGBOOK drawer for logs
      org_blank_before_new_entry = { heading = false, plain_list_item = false },
      org_startup_folded = "overview",
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

          if not vim.tbl_isempty(result) then
            Snacks.notifier.notify(table.concat(result, "\n"), vim.log.levels.INFO, {
              title = "Orgmode",
            })
          end
        end,
      },
      org_capture_templates = {
        w = {
          description = "Work-related task",
          template = "* TODO %?",
          target = "~/Documents/notes/work/tasks.org",
        },
        p = {
          description = "Personal-life-related task",
          template = "* TODO %?",
          target = "~/Documents/notes/personal/life/tasks.org",
        },
      },
    })
    require("org-bullets").setup()
  end,
}
