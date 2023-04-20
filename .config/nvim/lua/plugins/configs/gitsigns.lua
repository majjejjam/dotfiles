require('gitsigns').setup({
        signs = {
            add = {hl = 'GitSignsAdd', text = '│', numhl = 'Constant', linehl = 'GitSignsAddLn'},
            change = {
                hl = 'GitSignsChange',
                text = '│',
                numhl = 'Type',
                linehl = 'GitSignsChangeLn'
            },
            delete = {
                hl = 'GitSignsDelete',
                text = '_',
                numhl = 'Identifier',
                linehl = 'GitSignsDeleteLn'
            },
            topdelete = {
                hl = 'GitSignsDelete',
                text = '‾',
                numhl = 'ErrorMsg',
                linehl = 'GitSignsDeleteLn'
            },
            changedelete = {
                hl = 'GitSignsChange',
                text = '~',
                numhl = 'Number',
                linehl = 'GitSignsChangeLn'
            }
        },
        signcolumn = false,
        numhl = true,
        linehl = false,
        word_diff = true,
        watch_gitdir = {interval = 2000, follow_files = true},
        attach_to_untracked = true,
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
            border = 'rounded',
            style = 'minimal',
            relative = 'cursor',
            noautocmd = true,
            row = 0,
            col = 1
        },
        show_deleted = false,
        trouble = false,
        yadm = {enable = false}
    })
