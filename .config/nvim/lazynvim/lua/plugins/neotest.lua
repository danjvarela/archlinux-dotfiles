return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "Issafalcon/neotest-dotnet",
  },
  opts = {
    adapters = {
      ["neotest-dotnet"] = {},
    },
  },
}
