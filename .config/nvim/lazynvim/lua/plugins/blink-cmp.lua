return {
  {
    "hrsh7th/cmp-calc",
  },
  {
    "saghen/blink.compat",
    -- use v2.* for blink.cmp v1.*
    version = "2.*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        default = { "avante", "calc" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
          calc = {
            name = "calc",
            module = "blink.compat.source",
          },
        },
      },
    },
  },
}
