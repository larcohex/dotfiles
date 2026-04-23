-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local nomap = vim.keymap.del

nomap("n", "<leader>xl")
nomap("n", "<leader>xq")

map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>x", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>X", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader><C-x>", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map({ "n", "i" }, "<leader>df", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
