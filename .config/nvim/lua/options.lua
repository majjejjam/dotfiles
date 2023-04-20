vim.g.loaded_matchit = 1

local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
-- local create_augroup = require('utils').create_augroup

-- -- Ignore compiled files
vim.o.wildignore = '__pycache__'
vim.opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
vim.opt.wildignore:append { "Cargo.lock" }

-- Cool floating window popup menu for completion on command line
vim.o.pumblend = 17
vim.o.wildmode = "longest:full"
vim.o.wildoptions = "pum"

vim.o.showmode = false
vim.o.showcmd = true
vim.o.title = true
vim.o.lazyredraw = false
vim.o.cmdheight = 0 -- Height of the command bar
vim.o.incsearch = true -- Makes search act like search in modern browsers
vim.o.showmatch = true -- show matching brackets when text indicator is over them
vim.o.relativenumber = true -- Show line numbers
vim.o.number = true -- But show the actual number for the line we're on
vim.o.numberwidth = 2
vim.o.signcolumn = 'yes:1'
vim.o.ignorecase = true -- Ignore case when searching...
vim.o.smartcase = true -- ... unless there is a capital letter in the query
vim.o.gdefault = true -- default to substitute all instances on line
vim.o.hidden = true -- I like having buffers stay around
vim.o.equalalways = false -- I don't like my windows changing all the time
vim.o.splitright = true -- Prefer windows splitting to the right
vim.o.splitbelow = true -- Prefer windows splitting to the bottom
vim.o.updatetime = 1000 -- Make updates happen faster
vim.o.hlsearch = true -- I wouldn't use this without my DoNoHL function
vim.o.scrolloff = 4 -- Make it so there are always ten lines below my cursor
vim.o.sidescrolloff = 3
vim.cmd([[set mousescroll=ver:1,hor:1]])
vim.o.conceallevel = 2 -- Remove clutter
vim.o.laststatus = 3 -- Global statusline

-- Disable using netrw for 'gx' and set it manually
g.netrw_nogx = 1
vim.keymap.set('n', 'gx', '<cmd>!xdg-open <cfile><CR>', {})

g.tex_flavor = "latex"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- vim.opt.whichwrap:append { "<>[]hl" }

-- vim.o.guifont = "FiraCode Nerd Font Mono:h10.67"
vim.o.guifont = "JetBrainsMonoMedium Nerd Font:h10"

-- Cursorline highlighting control
--  Only have it on in the active buffer
vim.o.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- No line numbers in terminal
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Tabs
vim.o.autoindent = true
vim.o.cindent = true
vim.o.wrap = true

vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = false

vim.o.breakindent = true
vim.o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.o.linebreak = true

vim.o.foldmethod = "marker"
vim.o.foldlevel = 0
vim.o.modelines = 1

vim.o.belloff = "all" -- Just turn the dang bell off

vim.o.clipboard = "unnamedplus"

-- vim.o.inccommand = "nosplit"
vim.o.swapfile = false -- Living on the edge
vim.opt.shada = { "!", "'1000", "<50", "s10", "h" }

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- set joinspaces
vim.o.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
-- vim.opt.fillchars = { eob = " " }

vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Disable builtins
require("disable-builtins")

-- -- fold settings
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext =
--     [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1

-- Colorscheme
-- luafile ~/.config/nvim/lua/background.lua
-- require("background")
local function eval_background()
	local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme", "r")
	local result = handle:read("*a")
	handle:close()
	if result == '\'default\'\n' then
	    vim.o.background='light'
	else
	    vim.o.background='dark'
	end
end
eval_background()
vim.o.termguicolors = true
-- vim.g.adwaita_darker = true
-- vim.g.adwaita_disable_cursorline = true
vim.cmd.colorscheme('adwaita')
