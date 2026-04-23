local image = vim.fn.stdpath("config") .. "/logo.png"

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "chafa " .. image .. " --format symbols --symbols vhalf --size 30x15",
          width = 30,
          height = 15,
          padding = 1,
        },
        {
          pane = 2,
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
