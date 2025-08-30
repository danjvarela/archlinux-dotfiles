local orgmode = vim.fn.stdpath("data") .. "/lazy/orgmode"
vim.opt.runtimepath:append(orgmode)

local personal_agenda_orgfiles_path = "~/Documents/notes/personal/life/**/*"
local work_agenda_orgfiles_path = "~/Documents/notes/work/**/*"

-- Run the orgmode cron
require("orgmode").cron({
  org_agenda_files = { personal_agenda_orgfiles_path, work_agenda_orgfiles_path, "~/Documents/notes/*" },
  org_default_notes_file = "~/Documents/notes/refile.org",
  notifications = {
    reminder_time = { 0, 5, 10 },
  },
})
