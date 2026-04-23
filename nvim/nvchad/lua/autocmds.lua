require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- Checks if opened a git repo, used to lazy load lazygit
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.system "git rev-parse --is-inside-work-tree"
    if vim.v.shell_error == 0 then
      vim.api.nvim_exec_autocmds("User", {
        pattern = "IsGitRepo",
      })
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    vim.wo.wrap = true
  end,
})
-- Contains code for lazy loading nvim-tree and showing dashboard if neovim is opened without file or directory - incompatible with auto-session
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = "NvimTree*",
--   callback = function()
--     local api = require "nvim-tree.api"
--
--     if not api.tree.is_visible() then
--       api.tree.open()
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv()[1]) ~= 0 then
--       vim.api.nvim_exec_autocmds("User", {
--         pattern = "IsEnterDir",
--       })
--       return true
--     elseif vim.fn.argc() == 0 then
--       error(vim.fn.argv())
--       vim.cmd "Nvdash"
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufAdd", {
--   callback = function()
--     if vim.fn.isdirectory(vim.fn.expand "%") ~= 0 then
--       vim.api.nvim_exec_autocmds("User", {
--         pattern = "IsEditDir",
--       })
--       return true
--     end
--   end,
-- })
