return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "luadoc",
      "vimdoc",
      "printf",
      "html",
      "css",
      "angular",
      "javascript",
      "typescript",
      "scss",
      "astro",
    },
  },
}
