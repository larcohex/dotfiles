vim.lsp.handlers["textDocument/references"] = function(_, result)
  vim.g.lsp_last_word = vim.fn.expand "<cword>"
  if not result then
    return
  end
  if #result == 0 then
    vim.cmd 'echo "Getting references..."'
    return
  end
  vim.cmd 'echo ""'
  local util = require "vim.lsp.util"
  util.set_qflist(util.locations_to_items(result))
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()

      local mason_packages_path = vim.fn.stdpath "data" .. "/mason/packages/"

      -- angularls --
      local angular_lsp_path = mason_packages_path .. "angular-language-server/node_modules/"
      local angular_lsp_cmd = {
        "ngserver",
        "--stdio",
        "--tsProbeLocations",
        angular_lsp_path .. "typescript/lib",
        "--ngProbeLocations",
        angular_lsp_path .. "@angular/language-server/bin",
      }

      vim.lsp.config("angularls", {
        cmd = angular_lsp_cmd,
      })

      -- astro --
      local astro_ts_path = mason_packages_path .. "astro-language-server/node_modules/typescript/lib"
      vim.lsp.config("astro", {
        init_options = {
          typescript = {
            tsdk = astro_ts_path,
          },
        },
      })

      local servers = {
        "angularls",
        "cssls",
        "stylua",
        "tailwindcss",
        "vtsls",
        "vue_ls",
        "astro",
      }
      vim.lsp.enable(servers)

      vim.diagnostic.config {
        underline = false,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      }
    end,
  },
  {
    "TomDeneire/lsp-in-gutter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-in-gutter").setup {
        icons = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
        show_icons = true,
        show_lnum = true,
        show_colors = true,
        -- optional formatter that takes a vim.Diagnostic object
        -- e.g. function(diagnostic) return diagnostic.message end
        format = nil,
      }
    end,
  },
}
