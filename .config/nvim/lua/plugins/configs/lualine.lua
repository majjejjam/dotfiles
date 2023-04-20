require('lualine').setup {
  options = {
    -- globalstatus = true,
    theme = "adwaita",
    section_separators = '',
    component_separators = '',
  },
  extensions = { 'quickfix', 'nvim-tree' },
}
