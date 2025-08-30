return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  enabled = false,
  config = function()
    require("easy-dotnet").setup()
  end,
}
