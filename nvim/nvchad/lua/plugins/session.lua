return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local map = vim.keymap.set
    local function close_nvim_tree()
      require("nvim-tree.api").tree.close()
    end
    local function open_nvim_tree()
      require("nvim-tree.api").tree.open()
    end
    local function open_dashboard()
      if vim.fn.argc() == 0 then
        vim.defer_fn(function()
          vim.cmd "Nvdash"
        end, 0)
      end
    end
    require("auto-session").setup {
      git_auto_restore_on_branch_change = true,
      git_use_branch_name = true,
      session_lens = {
        picker = "telescope",
        picker_opts = {
          layout_config = {
            width = 0.4,
            height = 0.4,
          },
        },
        load_on_setup = true,
      },
      bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard", "nvdash" },
      pre_save_cmds = { close_nvim_tree },
      post_save_cmds = { open_nvim_tree },
      post_open_cmds = { open_nvim_tree },
      post_restore_cmds = { open_nvim_tree },
      no_restore_cmds = { open_dashboard },
      cwd_change_handling = {
        restore_upcoming_session = true,
        pre_cwd_changed_hook = close_nvim_tree,
        post_cwd_changed_hook = open_nvim_tree,
      },
    }
    map("n", "<leader>sf", "<cmd>AutoSession search<cr>", { desc = "Search Session" })
    map("n", "<leader>ss", "<cmd>AutoSession save<cr>", { desc = "Save Session" })
    map("n", "<leader>sr", "<cmd>AutoSession restore<cr>", { desc = "Restore Session" })
    map("n", "<leader>sd", "<cmd>AutoSession delete<cr>", { desc = "Delete Session" })
  end,
}
