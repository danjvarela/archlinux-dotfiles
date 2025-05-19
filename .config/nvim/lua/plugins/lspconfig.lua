return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      omnisharp = {
        -- because mason-installed omnisharp executable is now named `OmniSharp` instead of `omnisharp`
        cmd = {
          "OmniSharp",
          "-z",
          "--hostPID",
          vim.fn.getpid() .. "",
          "DotNet:enablePackageRestore=false",
          "--encoding",
          "utf-8",
          "--languageserver",
        },
      },
    },
  },
}
