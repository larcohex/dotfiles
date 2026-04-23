local config = require "nvchad.configs.telescope"

config.defaults.mappings.n["l"] = require("telescope.actions").cycle_history_next
config.defaults.mappings.n["h"] = require("telescope.actions").cycle_history_prev
config.defaults.wrap_results = true

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = "Telescope",
  opts = config,
}
