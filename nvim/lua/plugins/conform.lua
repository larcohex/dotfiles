return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "eslint_d" },
      typescript = { "prettierd", "eslint_d" },
      htmlangular = { "prettierd", "eslint_d" },
      vue = { "prettierd", "eslint_d" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      ["*"] = { "codespell" },
    },
    format_on_save = {
      timeout_ms = 10000,
      lsp_format = "fallback",
    },
  },
}
