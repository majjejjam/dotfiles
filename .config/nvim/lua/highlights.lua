
-- 
-- -- get colours
-- local colors = require('adwaita.utils').gen_colors()
-- 
-- -- vim.cmd(--hi NvimTreeFolderIcon guifg=-- .. colors.blue_3)
-- -- gray
-- vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
-- -- blue
-- vim.cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=" .. colors.blue_4)
-- vim.cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=" .. colors.blue_1)
-- -- light blue
-- vim.cmd("highlight! CmpItemKindVariable guibg=NONE guifg=" .. colors.teal_1)
-- vim.cmd("highlight! CmpItemKindInterface guibg=NONE guifg=" .. colors.teal_1)
-- vim.cmd("highlight! CmpItemKindText guibg=NONE guifg=" .. colors.teal_1)
-- -- pink
-- vim.cmd("highlight! CmpItemKindFunction guibg=NONE guifg=" .. colors.purple_1)
-- vim.cmd("highlight! CmpItemKindMethod guibg=NONE guifg=" .. colors.purple_1)
-- -- front
-- vim.cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=" .. colors.dark_1)
-- vim.cmd("highlight! CmpItemKindProperty guibg=NONE guifg=" .. colors.dark_1)
-- vim.cmd("highlight! CmpItemKindUnit guibg=NONE guifg=" .. colors.dark_1)
--

vim.cmd("hi! link SignColumn EndOfBuffer")
