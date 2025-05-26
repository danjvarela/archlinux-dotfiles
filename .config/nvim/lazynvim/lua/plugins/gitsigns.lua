return {
  "gitsigns.nvim",
  dependencies = {
    {
      "purarue/gitsigns-yadm.nvim",
      opts = {
        shell_timeout_ms = 1000,
      },
    },
  },
  opts = {
    _on_attach_pre = function(bufnr, callback)
      require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
    end,
  },
}
