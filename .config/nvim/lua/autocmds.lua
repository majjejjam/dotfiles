local my_augroup = vim.api.nvim_create_augroup("my_augroup", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Disable statusline in dashboard
autocmd("FileType", {
   pattern = "alpha",
   callback = function()
      vim.opt.laststatus = 0
      -- vim.opt.winbar = ""
   end,
})

-- autocmd({"WinEnter", "BufEnter"}, {
--   pattern = "*", -- disable spellchecking in the embeded terminal
--   command = "setlocal statusline=%!v:lua.require('statusline').Statusline('active') | lua vim.o.winbar = vim.o.statusline",
--   -- command = "echo 'hej'",
--   group = my_augroup,
-- })
--
-- autocmd({"WinLeave", "BufLeave"}, {
--   pattern = "*", -- disable spellchecking in the embeded terminal
--   command = "setlocal statusline=%!v:lua.require('statusline').Statusline('inactive') | lua vim.o.winbar = vim.o.statusline",
--   -- command = "echo 'hej'",
--   group = my_augroup,
-- })

-- autocmd("BufUnload", {
--    buffer = 0,
--    callback = function()
--       vim.opt.laststatus = 3
--       -- vim.cmd [[
--       -- set winbar=%=%m\ %f
--       -- ]]
--       -- require('plugins.configs.feline')
--    end,
-- })

-- autocmd({"BufRead", "BufNewFile"}, { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell | set spelllang=sv" })


autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embeded terminal
  command = "setlocal nospell",
  group = my_augroup,
})

-- lilypond
autocmd('BufEnter', {
  command = "syntax sync fromstart",
  pattern = { '*.ly', '*.ily' }
})

-- -- lilypond compile
-- autocmd("BufWritePost", {
--     pattern = "*.ly",
--     desc = "Compiles lilypond files on write",
--     command = "!lilypond -s %",
-- })

