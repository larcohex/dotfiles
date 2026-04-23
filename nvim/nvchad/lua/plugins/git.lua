return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "User IsGitRepo",
  config = function()
    local map = vim.keymap.set
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new {
      cmd = "lazygit",
      hidden = true,
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      on_close = function(term)
        vim.cmd "startinsert!"
      end,
    }

    function lazygit_toggle()
      lazygit:toggle()
    end

    require("toggleterm").setup {}

    map("n", "<leader>gg", "<cmd>lua lazygit_toggle()<CR>", { noremap = true, silent = true })
  end,
}
