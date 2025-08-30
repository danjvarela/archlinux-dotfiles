return {
	"mason-org/mason.nvim",
	opts = {
		ensure_installed = { "prettierd", "roslyn", "netcoredbg", "vtsls", "lua-language-server", "eslint_d" },
		registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		},
	},
}
