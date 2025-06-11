local orgmode = vim.fn.stdpath("data") .. "/lazy/orgmode"
vim.opt.runtimepath:append(orgmode)

-- Run the orgmode cron
require("orgmode").cron({
  org_agenda_files = { "~/.orgfiles/**/*", "~/Orgfiles/**/*" },
  org_default_notes_file = "~/.orgfiles/refile.org",
  notifications = {
    reminder_time = { 0, 5, 10 },
  },
})
