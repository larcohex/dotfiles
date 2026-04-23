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
    "robitx/gp.nvim",
    lazy = false,
    cond = function()
      return os.getenv("OPENAI_API_KEY") ~= nil or copilotKey ~= nil
    end,
    config = function()
      local conf = {
        open_api_key = os.getenv("OPENAI_API_KEY"),
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

      local map = vim.keymap.set
      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = "GPT prompt " .. desc,
        }
      end

      -- Chat commands

      map({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
      map({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
      map({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

      map("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
      map("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
      map("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

      map({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
      map({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
      map({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

      map("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
      map("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
      map("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

      -- Prompt commands
      map({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
      map({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
      map({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

      map("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
      map("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
      map("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
      map("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

      map({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
      map({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
      map({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
      map({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
      map({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

      map("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
      map("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
      map("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
      map("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
      map("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

      map({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
      map("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

      map({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
      map({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
      map({ "n", "i", "v", "x" }, "<C-g>l", "<cmd>GpSelectAgent<cr>", keymapOptions("Select Agent"))

      -- optional Whisper commands with prefix <C-g>w
      map({ "n", "i" }, "<C-g>ww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
      map("v", "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

      map({ "n", "i" }, "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
      map({ "n", "i" }, "<C-g>wa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
      map({ "n", "i" }, "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

      map("v", "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
      map("v", "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
      map("v", "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions("Visual Whisper Prepend (before)"))

      map({ "n", "i" }, "<C-g>wp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
      map({ "n", "i" }, "<C-g>we", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper New"))
      map({ "n", "i" }, "<C-g>wn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
      map({ "n", "i" }, "<C-g>wv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
      map({ "n", "i" }, "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

      map("v", "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
      map("v", "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper New"))
      map("v", "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
      map("v", "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
      map("v", "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))
    end,
  },
}
