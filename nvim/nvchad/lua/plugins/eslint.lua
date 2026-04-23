return {
  "esmuellert/nvim-eslint",
  event = "InsertEnter",
  config = function()
    require("nvim-eslint").setup {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
        "html",
        "htmlangular",
      },
    }
  end,
}
