vim.lsp.handlers["textDocument/references"] = function(_, result)
  vim.g.lsp_last_word = vim.fn.expand("<cword>")
  if not result then
    return
  end
  if #result == 0 then
    vim.cmd('echo "Getting references..."')
    return
  end
  vim.cmd('echo ""')
  local util = require("vim.lsp.util")
  util.set_qflist(util.locations_to_items(result))
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
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
      },
      servers = {
        ["harper-ls"] = {
          filetypes = { "markdown", "text", "tex", "typst" },
        },
      },
    },
  },
  {
    "TomDeneire/lsp-in-gutter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-in-gutter").setup({
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
      })
    end,
  },
}
