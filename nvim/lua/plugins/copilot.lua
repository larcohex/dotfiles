return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        nes = {
          enabled = true,
          keymap = {
            accept_and_goto = "<leader>p",
            accept = false,
            dismiss = "<Esc>",
          },
        },
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    "robitx/gp.nvim",
    lazy = false,
    cond = function()
      return os.getenv "OPENAI_API_KEY" ~= nil or os.getenv "GITHUB_COPILOT_API_KEY" ~= nil
    end,
    config = function()
      local conf = {
        open_api_key = os.getenv "OPENAI_API_KEY",
        providers = {
          openai = {
            disable = true,
            endpoint = "https://api/openai.com/v1/chat/completions",
          },
          copilot = {
            disable = false,
            endpoint = "https://api.githubcopilot.com/chat/completions",
            -- TODO: make a cross os solution to get api key from copilot plugin
            secret = os.getenv "GITHUB_COPILOT_API_KEY",
          },
        },
      }
      require("gp").setup(conf)
    end,
  },
}
