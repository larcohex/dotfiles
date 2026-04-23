local function getOS()
  -- ask LuaJIT first
  if jit then
    return jit.os
  end

  -- Unix, Linux variants
  local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    osname = fh:read()
  end

  return osname or "Windows"
end

local function retrieveCopilotKey()
  local command
  if getOS() == "Windows" then
    command = {
      "powershell",
      "-Command",
      [[(Get-Content "$env:LocalAppData\github-copilot\apps.json" | Select-String -Pattern '"oauth_token"\s*:\s*"([^"]*)"' -AllMatches).Matches.Groups[1].Value]],
    }
  else
    command = {
      "bash",
      "-c",
      "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
    }
  end
  return string.gsub(vim.fn.system(command), "%s+", "")
end

local copilotKey = retrieveCopilotKey()

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
      return os.getenv "OPENAI_API_KEY" ~= nil or copilotKey ~= nil
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
            secret = copilotKey,
          },
        },
      }
      require("gp").setup(conf)
    end,
  },
}
