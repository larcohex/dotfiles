return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["gf"] = "fzf_find",
            ["gg"] = "fzf_grep",
          },
        },
      },
      commands = {
        fzf_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("fzf-lua").files({ cwd = path })
        end,
        fzf_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("fzf-lua").live_grep({ cwd = path })
        end,
      },
    },
    keys = {
      { "<leader>e", "<Cmd>Neotree focus<CR>", "Explorer NeoTree (focus)", remap = true },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
      local lspconfig = require("lspconfig")

      -- Set global defaults for all servers
      lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        capabilities = vim.tbl_deep_extend(
          "force",
          vim.lsp.protocol.make_client_capabilities(),
          -- returns configured operations if setup() was already called
          -- or default operations if not
          require("lsp-file-operations").default_capabilities()
        ),
      })
    end,
  },
}
