return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      css = { css = true },
      json = { css = true },
      js = { css = true },
      ts = { css = true },
      toml = { css = true },
      yaml = { css = true },
    })
  end,
}
