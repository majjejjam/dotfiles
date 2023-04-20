vim.keymap.set('n', '<leader>p', ':lua require("nabla").popup({border = "rounded"})<CR>', {silent = true})
-- nnoremap <leader>p :lua require("nabla").popup()<CR> " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
