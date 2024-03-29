local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

-- local function update_mode_colors()
--   local current_mode = vim.api.nvim_get_mode().mode
--   local mode_color = "%#StatusLineAccent#"
--   if current_mode == "n" then
--       mode_color = "%#StatuslineAccent#"
--   elseif current_mode == "i" or current_mode == "ic" then
--       mode_color = "%#StatuslineInsertAccent#"
--   elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
--       mode_color = "%#StatuslineVisualAccent#"
--   elseif current_mode == "R" then
--       mode_color = "%#StatuslineReplaceAccent#"
--   elseif current_mode == "c" then
--       mode_color = "%#StatuslineCmdLineAccent#"
--   elseif current_mode == "t" then
--       mode_color = "%#StatuslineTerminalAccent#"
--   end
--   return mode_color
-- end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
    if fpath == "" or fpath == "." then
	return " "
    end

    return string.format(" %%<%s/", fpath)
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then
    	return ""
    end
    return fname .. " "
end

local function lsp()
    local count = {}
    local levels = {
	errors = "ERROR",
	warnings = "WARN",
	info = "INFO",
	hints = "HINT",
    }

    for k, level in pairs(levels) do
	count[k] = vim.tbl_count(vim.diagnostic.get(0, {severity = level}))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
	errors = " %#DiagnosticsError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
	warnings = " %#DiagnosticsWarn# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
	hints = " %#DiagnosticsHint# " .. count["hints"]
    end
    if count["info"] ~= 0 then
	info = " %#DiagnosticsInfo# " .. count["info"]
    end

    return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
    return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
    if vim.bo.filetype == "alpha" then
	return ""
    end
    return " %P %l:%c "
end

Statusline = {}

Statusline.active = function ()
    return table.concat {
	mode(),
	lsp(),
	"%=",
	"%#Statusline#",
	filepath(),
	filename(),
	filetype(),
	"%#Normal#",
	"%=",
	lineinfo(),
    }
end

function Statusline.inactive()
    return "%=%#CursorLine#%F%#Normal#%="
end

function Statusline.short()
    return "%#StatuslineNC#    NvimTree"
end

local statusline_augroup = vim.api.nvim_create_augroup("statusline_augroup", { clear = true })

vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
  pattern = "*", -- disable spellchecking in the embeded terminal
    -- command = "setlocal statusline=%!v:lua.Statusline.active() | lua vim.opt_local.winbar=vim.o.statusline  echo 'h'",
    callback = function ()
    	vim.opt.statusline='%!v:lua.Statusline.active()'
	-- vim.opt_local.winbar=vim.o.statusline
	-- vim.o.statusline='%#Normal#'
    end,
  group = statusline_augroup,
})

vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
  pattern = "*", -- disable spellchecking in the embeded terminal
  -- command = "setlocal statusline=%!v:lua.Statusline.inactive() | lua vim.opt_local.winbar=vim.o.statusline",
    callback = function ()
    	vim.opt.statusline='%!v:lua.Statusline.inactive()'
	-- vim.opt_local.winbar=vim.o.statusline
	-- vim.o.statusline='%#Normal#'
    end,
  group = statusline_augroup,
})

-- Hide statusline by setting laststatus and cmdheight to 0.
vim.o.laststatus = 3
vim.o.cmdheight = 1
