vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Configuration to load after loading plugins
local function load_post_plugin_config()
    require('plugins')
    require('impatient') -- Use impatient.nvim to load Lua modules faster
    require('statusline')
    require('options')
    require('keymaps')
    require('autocmds')
    require('tabline')
    require('highlights')
end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

load_post_plugin_config()
