vim.pack.add({
	"https://github.com/onsails/lspkind.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^v1.9.1") },
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = { nerd_font_variant = "mono" },
  snippets = { preset = "mini_snippets" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		per_filetype = {
			codecompanion = { "codecompanion" },
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	-- experimental
	signature = { enabled = true },
	completion = {
		-- Disable auto brackets
		-- NOTE: some LSPs may add auto brackets themselves anyway
		accept = { auto_brackets = { enabled = false } },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							if ctx.source_name ~= "Path" then
								return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
							end

							local is_unknown_type = vim.tbl_contains(
								{ "link", "socket", "fifo", "char", "block", "unknown" },
								ctx.item.data.type
							)
							local mini_icon, _ = require("mini.icons").get(
								is_unknown_type and "os" or ctx.item.data.type,
								is_unknown_type and "" or ctx.label
							)

							return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
						end,

						highlight = function(ctx)
							if ctx.source_name ~= "Path" then
								return ctx.kind_hl
							end

							local is_unknown_type = vim.tbl_contains(
								{ "link", "socket", "fifo", "char", "block", "unknown" },
								ctx.item.data.type
							)
							local mini_icon, mini_hl = require("mini.icons").get(
								is_unknown_type and "os" or ctx.item.data.type,
								is_unknown_type and "" or ctx.label
							)
							return mini_icon ~= nil and mini_hl or ctx.kind_hl
						end,
					},
				},
			},
		},
	},
})
