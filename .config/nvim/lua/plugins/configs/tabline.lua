require'tabline'.setup {
    -- Defaults configuration options
    enable = true,
    options = {
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_filename_only = true, -- shows base filename only instead of relative path in filename
        section_separators = {'', ''},
        component_separators = {'', ''},
    }
}

vim.cmd[[
set guioptions-=e " Use showtabline in gui vim
set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]
