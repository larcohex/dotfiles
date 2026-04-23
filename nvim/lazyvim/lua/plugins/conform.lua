return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    default_format_opts = {
      timeout_ms = 10000,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "eslint_d" },
      typescript = { "prettierd", "eslint_d" },
      html = { "prettierd" },
      htmlangular = { "prettierd", "eslint_d" },
      css = { "prettierd" },
      scss = { "prettierd" },
      ["*"] = function(bufnr)
        if vim.g.disable_codespell or vim.b[bufnr].disable_codespell then
          return {}
        end
        return { "codespell" }
      end,
    },
  },
}
