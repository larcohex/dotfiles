local nvchad_blink = require "nvchad.blink.lazyspec"
local plugin = nvchad_blink[2]
local opts = nvchad_blink[2].opts()

local default = { "lsp", "snippets", "buffer", "path" }
-- uncomment to install copilot support
-- table.insert(plugin.dependencies, "giuxtaposition/blink-cmp-copilot")
-- table.insert(default, "copilot")
opts.keymap["<CR>"] = nil
opts.keymap["<C-CR>"] = { "accept", "fallback" }
opts.completion.list = {
  selection = {
    preselect = false,
  },
}
opts.sources = {
  default = default,
  -- uncomment to install copilot support
  -- providers = {
  --   copilot = {
  --     name = "copilot",
  --     module = "blink-cmp-copilot",
  --     score_offset = 100,
  --     async = true,
  --   },
  -- },
}
plugin.opts = opts
return nvchad_blink
