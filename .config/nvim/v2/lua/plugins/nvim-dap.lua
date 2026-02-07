return {
	"mfussenegger/nvim-dap",
	lazy = true,
	dependencies = {
		{
			"igorlfs/nvim-dap-view",
			opts = {},
		},
		"nvim-neotest/nvim-nio",
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle breakpoint",
		},

		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Continue",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step into",
		},
		{
			"<leader>dx",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step out",
		},
	},
	config = function()
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapBreakpointRejected", { text = "✖", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

		vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "Error" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { link = "Info" })
		vim.api.nvim_set_hl(0, "DapStopped", { link = "WarningMsg" })
		vim.api.nvim_set_hl(0, "DapStoppedLine", { link = "Visual" })

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

		local dap, dapview = require("dap"), require("dap-view")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapview.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapview.close
		dap.listeners.before.event_exited["dapui_config"] = dapview.close
	end,
}
