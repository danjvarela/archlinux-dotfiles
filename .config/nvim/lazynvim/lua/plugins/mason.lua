return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = { "prettierd", "roslyn" },
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
  },
}
