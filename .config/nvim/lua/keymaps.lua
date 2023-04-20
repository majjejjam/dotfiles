local keymap = vim.keymap
local opts = { silent = true }

keymap.set("n", "<leader>cd", ":tc %:h<CR>:tc `git rev-parse --show-toplevel`<CR>:pwd<CR>")

-- Don't leave visual mode after indenting
keymap.set('v', '>', '>gv^', {})
keymap.set('v', '<', '<gv^', {})

-- smart delete
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end
keymap.set( "n", "dd", smart_dd, { noremap = true, expr = true } )

-- Apply the . command to all selected lines in visual mode
keymap.set('v', '.', ':normal .<CR>', opts)

-- Search with hlslens
keymap.set("n", "*", "", {
  callback = function()
    vim.fn.execute("normal! *N")
    require('hlslens').start()
  end,
})
keymap.set("n", "#", "", {
  callback = function()
    vim.fn.execute("normal! #N")
    require('hlslens').start()
  end,
})

-- Previous/next buffer
keymap.set('n', '[b', ':bprevious<CR>', opts)
keymap.set('n', ']b', ':bnext<CR>', opts)

-- Common sense
keymap.set({ "n", "x" }, "0", "^")
keymap.set({ "n", "x" }, "^", "0")
keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Undo break points
keymap.set("i", " ", " <c-g>u")
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", "!", "!<c-g>u")
keymap.set("i", "?", "?<c-g>u")
-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so don't worry about it

-- Don't copy the replaced text after pasting in visual mode
keymap.set("x", "p", "p:let @+=@0<CR>")

-- Previous/next tab
keymap.set('n', '[t', ':tabprevious<CR>', opts)
keymap.set('n', ']t', ':tabnext<CR>', opts)

-- Move current tab
keymap.set('n', '[T', ':tabmove -1<CR>', opts)
keymap.set('n', ']T', ':tabmove +1<CR>', opts)

-- Tab keybinds
-- Goto tab number
keymap.set('n', '<A-1>', ':tabnext1<CR>', opts)
keymap.set('n', '<A-2>', ':tabnext2<CR>', opts)
keymap.set('n', '<A-3>', ':tabnext3<CR>', opts)
keymap.set('n', '<A-4>', ':tabnext4<CR>', opts)
keymap.set('n', '<A-5>', ':tabnext5<CR>', opts)
keymap.set('n', '<A-6>', ':tabnext6<CR>', opts)
keymap.set('n', '<A-7>', ':tabnext7<CR>', opts)
keymap.set('n', '<A-8>', ':tabnext8<CR>', opts)
keymap.set('n', '<A-9>', ':tabnext9<CR>', opts)

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
keymap.set({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap.set({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
keymap.set("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
keymap.set("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- INSERT NAVIGATION
-- Scrolla
keymap.set("i", "<C-e>", "<C-x><C-e>")
keymap.set("i", "<C-y>", "<C-x><C-y>")

-- Insert new line
keymap.set("i", "<S-CR>", "<C-O>o")
keymap.set("i", "<C-CR>", "<C-O>O")

-- Navigation
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")

-- Window resizing
keymap.set("n", "+", "<C-w>+", opts)
keymap.set("n", "-", "<C-w>-", opts)
keymap.set("n", "<C-+>", "<C-w>>", opts)
keymap.set("n", "<C-->", "<C-w><", opts)

-- Window split navigation
keymap.set("n", "<C-h>", "<C-w><C-h>")
keymap.set("n", "<C-l>", "<C-w><C-l>")
keymap.set("n", "<C-j>", "<C-w><C-j>")
keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Terminal
keymap.set("t", "<C-x>", "<C-\\><C-N>")

-- Resizing
keymap.set("n", "<C-,>", "<C-w><")
keymap.set("n", "<C-.>", "<C-w>>")

-- PLUGINS
-- telescope
keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
keymap.set("n", "<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
keymap.set("n", "<leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>")
keymap.set("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>")
keymap.set("n", "<leader>8", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
keymap.set("n", "<leader>fy", "<cmd>lua require('telescope.builtin').registers()<cr>")
keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
keymap.set("n", "<leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>")
keymap.set("n", "z=", "<cmd>lua require('telescope.builtin').spell_suggest()<cr>")

-- ZK
-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

-- nvimtree
keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")

-- cool
function OpenURIUnderCursor()
    local function open_uri(uri)
        if type(uri) ~= 'nil' then
            uri = string.gsub(uri, "#", "\\#") --double escapes any # signs
            uri = '"'..uri..'"'
            vim.cmd('!xdg-open '..uri..' > /dev/null')
            vim.cmd('mode')
            -- print(uri)
            return true
        else
            return false
        end
    end

    local word_under_cursor = vim.fn.expand("<cWORD>")

    -- any uri with a protocol segment
    local regex_protocol_uri = "%a*:%/%/[%a%d%#%[%]%-%%+:;!$@/?&=_.,~*()]*"
    if (open_uri(string.match(word_under_cursor, regex_protocol_uri))) then return end

    -- consider anything that looks like string/string a GitHub link
    local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
    if (open_uri('https://github.com/'..string.match(word_under_cursor, regex_plugin_url))) then return end
end
vim.api.nvim_create_user_command('OpenURIUnderCursor', OpenURIUnderCursor, {})

keymap.set("n", "gx", OpenURIUnderCursor)

 -- --- returns a single input char 
 -- function get_char_input() return vim.fn.nr2char(vim.fn.getchar()) end
 --
 -- --- clears the command prompt 
 -- function clear_prompt() vim.api.nvim_command('normal! :') end
 --      local ask_install = {}
 --    
 --      function EnsureTSParserInstalled()
 --        local parsers = require 'nvim-treesitter.parsers'
 --        local lang = parsers.get_buf_lang()
 --    
 --        if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
 --          vim.schedule_wrap(function()
 --    
 --            local is_confirmed = false
 --            -- TODO: implement a Y/n prompt util func
 --            print('Install treesitter parser for '..lang.. ' ? Y/n')
 --            local res = get_char_input()
 --            if res:match('\r') then is_confirmed = true end
 --            if res:match('y') then is_confirmed = true end
 --            if res:match('Y') then is_confirmed = true end
 --            clear_prompt()
 --    
 --            if (is_confirmed) then
 --              vim.cmd('TSInstall '..lang)
 --            else
 --              ask_install[lang] = false
 --            end
 --          end)()
 --        end
 --      end
 --    
 --      -- TODO: convert to auto group
 --      vim.cmd [[au FileType * :lua EnsureTSParserInstalled()]]
