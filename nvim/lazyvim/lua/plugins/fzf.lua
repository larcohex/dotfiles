return {
  "ibhagwan/fzf-lua",
  opts = {
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-history",
    },
  },
  keys = {
    { "<leader>fw", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  },
}
