return {
  "pschmitt/telescope-yadm.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension("yadm_files")
    require("telescope").load_extension("git_or_files")
    require("telescope").load_extension("git_or_yadm_files")
  end,
}
