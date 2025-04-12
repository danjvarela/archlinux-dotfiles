return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-nvim-lsp-signature-help" },
  opts = function(_, opts)
    table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
  end,
}
