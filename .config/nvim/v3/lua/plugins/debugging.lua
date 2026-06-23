vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/igorlfs/nvim-dap-view",
	"https://github.com/mfussenegger/nvim-dap",
})

local dap, dapview = require("dap"), require("dap-view")
dapview.setup()

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "✖", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "Error" })
vim.api.nvim_set_hl(0, "DapLogPoint", { link = "Info" })
vim.api.nvim_set_hl(0, "DapStopped", { link = "WarningMsg" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { link = "Visual" })

require("dap").adapters.coreclr = {
	type = "executable",
	command = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "netcoredbg"),
	args = { "--interpreter=vscode" },
}

require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "js-debug-adapter"),
		args = { "${port}" },
	},
}

require("dap").adapters["pwa-msedge"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "js-debug-adapter"),
		args = { "${port}" },
	},
}

require("dap").adapters["pwa-chrome"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "js-debug-adapter"),
		args = { "${port}" },
	},
}

require("dap").adapters["node-terminal"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "js-debug-adapter"),
		args = { "${port}" },
	},
}

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapview.open()
end
dap.listeners.before.event_terminated["dapui_config"] = dapview.close
dap.listeners.before.event_exited["dapui_config"] = dapview.close

local map = vim.keymap.set
map("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Debug: Toggle breakpoint" })
map("n", "<leader>dc", function()
	dap.continue()
end, { desc = "Debug: Continue" })
map("n", "<leader>do", function()
	dap.step_over()
end, { desc = "Debug: Step over" })
map("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Debug: Step into" })
map("n", "<leader>dx", function()
	dap.step_out()
end, { desc = "Debug: Step out" })
