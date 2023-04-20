local api = vim.api

local vi_mode = require('feline.providers.vi_mode')
local git = require('feline.providers.git')
local lsp = require('feline.providers.lsp')


local components = { active = {}, inactive = {} }

-- Active statusline
components.active[1] = {
    {
        provider = 'git_branch',
        left_sep = ' ',
        right_sep = ' '
    },
    {
        provider = 'vi_mode',
        icon = '',
        hl = function()
            return {
                fg = 'bg',
                bg = vi_mode.get_mode_color(),
                style = 'bold'
            }
        end,
        left_sep = {
            {
                str = ' ',
                hl = function()
                    return {
                        bg = vi_mode.get_mode_color(),
                    }
                end,
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = function()
                    return {
                        bg = vi_mode.get_mode_color(),
                    }
                end,
            },
        },
    },
    {
        enabled = function()
            return vim.bo.filetype ~= ''
        end,
        provider = {
            name = 'file_type',
            opts = {
                case = 'titlecase',
                filetype_icon = true,
                colored_icon = true
            }
        },
        left_sep = ' ',
        right_sep = ' ',
    },
    {
        provider = 'diagnostic_errors',
        hl = function()
            return {
                fg = 'err',
            }
        end,
    },
    {
        provider = 'diagnostic_warnings',
        hl = function()
            return {
                fg = 'warn',
            }
        end,
    },
    {
        provider = 'diagnostic_hints',
        hl = function()
            return {
                fg = 'hint',
            }
        end,
    },
    {
        provider = 'diagnostic_info',
        hl = function()
            return {
                fg = 'info',
            }
        end,
    },
    {
        enabled = function()
            return lsp.diagnostics_exist()
        end,
        right_sep = { str = ' ', always_visible = true },
        left_sep = { str = ' ', always_visible = true }
    },
    -- {
    --     enabled = function()
    --         return gps.is_available()
    --     end,
    --     provider = function()
    --         return gps.get_location()
    --     end,
    -- }
}

components.active[2] = {
    -- {
    --     provider = {
    --         name = 'file_info',
    --         opts = {
    --             type = 'unique',
    --             colored_icon = false,
    --             file_modified_icon = '[+]'
    --         }
    --     },
    --     right_sep = ' '
    -- },
    {
        provider = 'git_diff_added',
    },
    {
        provider = 'git_diff_changed',
    },
    {
        provider = 'git_diff_removed',
    },
    {
        enabled = function()
            return git.git_info_exists()
        end,
        right_sep = { str = ' ', always_visible = true }
    },
    {
        provider = 'position',
        right_sep = ' '
    },
    {
        provider = 'scroll_bar',
        hl = function()
            return {
                fg = vi_mode.get_mode_color(),
                bg = 'lightgray'
            }
        end,
    },
}

components.inactive[1] = {
    {
        provider = 'git_branch',
        left_sep = ' ',
        right_sep = ' '
    },
    {
        provider = 'vi_mode',
        icon = '',
        hl = function()
            return {
                fg = bg,
                bg = vi_mode.get_mode_color(),
                style = 'bold'
            }
        end,
        left_sep = {
            {
                str = ' ',
                hl = function()
                    return {
                        bg = vi_mode.get_mode_color(),
                    }
                end,
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = function()
                    return {
                        bg = vi_mode.get_mode_color(),
                    }
                end,
            },
        },
    },
    {
        enabled = function()
            return vim.bo.filetype ~= ''
        end,
        provider = {
            name = 'file_type',
            opts = {
                case = 'titlecase',
                filetype_icon = true,
                colored_icon = true
            }
        },
        left_sep = ' ',
        right_sep = ' '
    },
    {
        provider = 'diagnostic_errors',
        hl = function()
            return {
                fg = 'err',
            }
        end,
    },
    {
        provider = 'diagnostic_warnings',
        hl = function()
            return {
                fg = 'warn',
            }
        end,
    },
    {
        provider = 'diagnostic_hints',
        hl = function()
            return {
                fg = 'hint',
            }
        end,
    },
    {
        provider = 'diagnostic_info',
        hl = function()
            return {
                fg = 'blue',
            }
        end,
    },
    {
        enabled = function()
            return lsp.diagnostics_exist()
        end,
        right_sep = { str = ' ', always_visible = true },
        left_sep = { str = ' ', always_visible = true }
    },
    -- {
    --     enabled = function()
    --         return gps.is_available()
    --     end,
    --     provider = function()
    --         return gps.get_location()
    --     end,
    -- }
}

components.inactive[2] = {
    {
        provider = 'position',
        right_sep = ' '
    }
}

local function get_hl(name)
        local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
        if not ok then
            return
        end
        for _, key in pairs({"foreground", "background", "special"}) do
            if hl[key] then
                hl[key] = string.format("#%06x", hl[key])
            end
        end
        return hl
    
end

-- if vim.o.background == 'dark' then
--     fg_color = get_hl('StatusLine')['foreground']
--     bg_color = colors.libadwaita_dark_alt
-- else
--     fg_color = colors.dark_5
--     bg_color = colors.light_3
-- end

-- Setup feline.nvim
require('feline').setup {
    components = components,
    theme = {
        fg = get_hl('StatusLine')['background'],
        bg = get_hl('StatusLine')['foreground'],
        -- lightgray = colors.light_4,
        -- gray = colors.dark_3,
        -- blue = colors.blue_3,
        -- green = fromhl(''),
        err = get_hl("DiagnosticError")['foreground'],
        hint = get_hl("DiagnosticHint")['foreground'],
        info = get_hl("DiagnosticInfo")['foreground'],
        warn = get_hl("DiagnosticWarn")['foreground'],
        -- red = fromhl('DiagnosticError').bg,
        -- skyblue = colors.blue_1,
        -- cyan = colors.teal_2,
        -- purple = colors.purple_1,
        -- darkpurple = colors.violet_2,
    },
    force_inactive = {
        filetypes = {
            '^NvimTree$',
            '^packer$',
            '^startify$',
            '^fugitive$',
            '^fugitiveblame$',
            '^qf$',
            '^help$',
        },
        buftypes = {
            '^terminal$',
            '^nofile$'
        },
    },
    custom_providers = {
        position_custom = function()
            local line, col = unpack(api.nvim_win_get_cursor(0))
            col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

            return string.format('%d∶%d', line, col)
        end
    },
}

-- Winbar
local winbar_components = {
    active = {
        {
            {
                provider = {
                    name = 'file_info',
                    opts = {
                        type = 'unique',
                        colored_icon = true,
                        file_modified_icon = '[+]'
                    },
                },
                left_sep = ' ',
                hl = {
                    fg = 'fg',
                },
            },
        },
    },
    inactive = {
        {
            {
                provider = {
                    name = 'file_info',
                    opts = {
                        type = 'unique',
                        colored_icon = false,
                        file_modified_icon = '[+]'
                    },
                },
                left_sep = ' ',
                hl = {
                    fg = 'gray',
                },
            }
        }
    }
}

-- Setup feline.nvim winbar
require('feline').winbar.setup{
    components = winbar_components,
}
