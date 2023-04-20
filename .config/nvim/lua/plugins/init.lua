-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function()
    -- Packer can manage itself
    use {'wbthomason/packer.nvim', event = "VimEnter" }
    use { "lewis6991/impatient.nvim" }

    -- AESTHETIC

    -- small
    -- use {
    --     "RRethy/vim-illuminate",
    -- }

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function() require('plugins.configs.blankline') end,
    }

    use {
        "kyazdani42/nvim-web-devicons",
        -- config = function() require('plugins.configs.icons') end,
    }

 --    -- Packer
 --    use({
	-- "folke/noice.nvim",
	-- event = "VimEnter",
	-- config = function()
	--     require("noice").setup()
	-- end,
	-- requires = {
	--     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	--     "MunifTanjim/nui.nvim",
	--     "rcarriga/nvim-notify",
	-- }
 --    })

    use {
	"stevearc/dressing.nvim",
	event = "BufRead",
	config = function ()
	    require("dressing").setup({
		input = {
		    insert_only = false,
		    prefer_width = 60,
		}
	    })
	end
    }

    -- -- statusline
    -- use {
    --     'famiu/feline.nvim',
    --     -- after = "catppuccin",
    --     config = function() require('plugins.configs.feline') end
    -- }

    -- colorschemes
    use 'Mofiqul/adwaita.nvim'
    -- use "rebelot/kanagawa.nvim"
    use {
        "ellisonleao/gruvbox.nvim",
        -- config = function()
        --     require('gruvbox').setup({
        --         overrides = {
        --             SignColumn = {bg = "ff9900"}
        --         }
        --     })
        -- end
    }
    -- use {
    --     "catppuccin/nvim",
    --     as = "catppuccin",
    --     config = function()
    --         vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha
    --         require("catppuccin").setup()
    --         -- vim.cmd [[ colorscheme catppuccin ]]
    --     end
    -- }

    -- Plugins can have post-install/update hooks
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

 --    use {
	-- "jczhang02/luasnips-mathtex-snippets",
	-- config = function()
	--     vim.cmd([[packadd LuaSnip]])
	--     vim.cmd([[packadd vimtex]])
	--     vim.cmd([[packadd vim-markdown]])
	--     require("luasnip-latex-snippets").setup()
	--     -- or setup({ use_treesitter = true })
	-- end,
	-- ft = { "tex", "markdown" },
 --    }

    use {
	"~/Projekt/luasnips-mathtex-snippets/",
	config = function()
	    vim.cmd([[packadd LuaSnip]])
	    vim.cmd([[packadd vimtex]])
	    vim.cmd([[packadd vim-markdown]])
	    require("luasnip-latex-snippets").setup()
	    -- or setup({ use_treesitter = true })
	end,
	ft = { "tex", "markdown", "norg" },
    }

    use {
	"preservim/vim-markdown",
	opt = true,
	ft = "markdown",
	config = function()
	    vim.cmd([[
	    let g:vim_markdown_math = 1
	    let g:vim_markdown_folding_disabled = 1
	    ]])
	end,
    }

 --    use {
	-- "nvim-neorg/neorg",
	-- -- ft = "norg",
	-- after = { "nvim-treesitter", "telescope.nvim" },
	-- run = ":Neorg sync-parsers",
	-- config = function()
	--     require('neorg').setup {
	-- 	load = {
	-- 	    ["core.defaults"] = {},
	-- 	    ["core.norg.journal"] = {},
	-- 	    ["core.norg.dirman"] = {
	-- 		config = {
	-- 		    workspaces = {
	-- 			home = "~/Nextcloud/Neorg",
	-- 			gtd = "~/Nextcloud/Neorg/gtd",
	-- 		    }
	-- 		}
	-- 	    },
	-- 	    ["core.norg.concealer"] = {},
	-- 	    ["core.norg.completion"] = {
	-- 		config = {
	-- 		    engine = "nvim-cmp",
	-- 		}
	-- 	    },
	-- 	    ["core.gtd.base"] = {
	-- 		config = {
	-- 		    workspace = "gtd",
	-- 		}
	-- 	    },
	-- 	}
	--     }
	-- end,
	-- requires = "nvim-lua/plenary.nvim"
 --    }

    use {
        "levouh/tint.nvim",
        config = function() require('tint').setup() end,
    }

    use {
        "ekickx/clipboard-image.nvim",
	ft = "markdown",
    }

    use {
	"nat-418/boole.nvim",
	config = function()
	    require('boole').setup({
		mappings = {
		    increment = '<C-a>',
		    decrement = '<C-x>'
		}
	    })
	end
    }

    use {
        'AckslD/nvim-trevJ.lua',
        config = 'require("trevj").setup()',  -- optional call for configurating non-default filetypes etc

        -- uncomment if you want to lazy load
        -- module = 'trevj',

        -- an example for configuring a keybind, can also be done by filetype
        setup = function()
            vim.keymap.set('n', '<leader>j', function()
                require('trevj').format_at_cursor()
            end)
        end,
    }

 --    use { "anuvyklack/windows.nvim",
	-- requires = {
	--     "anuvyklack/middleclass",
	--     "anuvyklack/animation.nvim"
	-- },
	-- config = function()
	--     vim.o.winwidth = 10
	--     vim.o.winminwidth = 10
	--     vim.o.equalalways = false
	--     vim.keymap.set('n', '<C-w>f', '<Cmd>WindowsMaximize<CR>')
	--     require('windows').setup()
	-- end
 --    }

    use { 
        "winston0410/range-highlight.nvim",
        requires = "winston0410/cmd-parser.nvim",
        config = function() require('range-highlight').setup() end
    }

    use {
        "numToStr/FTerm.nvim",
        keys = "<A-i>",
        config = function() require('plugins.configs.fterm') end,
    }

    use {
        'samodostal/image.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function ()
            require("image").setup({
                render = {
                    min_padding = 5,
                    show_label = true,
                    use_dither = true,
                },
                events = {
                    update_on_nvim_resize = true,
                },
            })
        end,
    }

    use {
        "axieax/urlview.nvim",
        config = function ()
            require("urlview").setup({
                default_action = "system",
            })
        end
    }

    use {
        'jghauser/mkdir.nvim'
    }

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function() require('colorizer').setup() end
    }

    use {
	"luukvbaal/stabilize.nvim",
	config = function() require("stabilize").setup() end
    }

    use {
        "ahmedkhalf/project.nvim",
        config = function () require("project_nvim").setup() end
    }

    use {
	"Pocco81/true-zen.nvim",
	cmd = {
	    "TZAtaraxis",
	    "TZMinimalist",
	    "TZFocus",
	},
	config = function()
	    -- require "configs.plugins.truezen"
	end,
    }

    use {
        "kevinhwang91/nvim-hlslens",
        event = "BufRead",
        keys = {
            {'n', 'n'}, {'x', 'n'}, {'o', 'n'}, {'n', 'N'}, {'x', 'N'}, {'o', 'N'}, {'n', '/'},
            {'n', '?'}, {'n', '*'}, {'x', '*'}, {'n', '#'}, {'x', '#'}, {'n', 'g*'},
            {'x', 'g*'}, {'n', 'g#'}, {'x', 'g#'}
        },
        -- config = function()
        --     require "plugins.configs.hlslens"
        -- end,
    }

    use {
        "mickael-menu/zk-nvim",
		-- ft = "markdown",
		config = function() require("zk").setup() end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufNewFile" },
        run = ":TSUpdate",
        config = function() require('plugins.configs.treesitter') end,
    }

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/nvim-treesitter-context"
    use "nvim-treesitter/playground"

    -- git stuff
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require('plugins.configs.gitsigns') end
    }

    -- lsp stuff

    use {
        "neovim/nvim-lspconfig",
        after = "nvim-cmp",
        config = function()
            require("plugins.configs.lspconfig")
        end,
    }

    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
    }

    -- use 'mfussenegger/nvim-jdtls' -- extra java lsp features

    use {
        "simrat39/symbols-outline.nvim",
        keys = "<C-p>",
        cmd = "SymbolsOutline",
        config = function() require('plugins.configs.symbols-outline') end,
    }

    use {'andymass/vim-matchup', event = 'VimEnter', opt = true }

    use { "j-hui/fidget.nvim", config = function() require('fidget').setup() end }

    -- load luasnips + cmp related in insert mode only

    use { "hrsh7th/cmp-nvim-lsp" }
    use { "rafamadriz/friendly-snippets", event = "InsertEnter" }
    use {
        "L3MON4D3/LuaSnip",
        after = "friendly-snippets",
	config = function ()
	    require('plugins.configs.luasnip')
	end,
    }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "hrsh7th/cmp-nvim-lua" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "uga-rosa/cmp-dictionary" }
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            {
                "KadoBOT/cmp-plugins",
                config = function ()
                    require("cmp-plugins").setup({
                        files = { "*.lua" }
                    })
                end,
            }
        },
        config = function() require('plugins.configs.cmp') end
    }

    use {
	"lervag/vimtex",
	-- setup = function ()
	--     vim.cmd([[let g:vimtex_quickfix_method=0]])
	-- end
	-- ft = "tex, md", -- bevövs ej då vimtex injicerar sig själv automatiskt
    }

    use {
	"ron-rs/ron.vim",
	ft = "ron"
    }

    use {
        'martineausimon/nvim-lilypond-suite',
        requires = { 'MunifTanjim/nui.nvim' }
    }

    -- misc plugins
    use {
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require("plugins.configs.autopairs")
        end,
    }

    -- use {
    --     "goolord/alpha-nvim",
    --     requires = { 'kyazdani42/nvim-web-devicons' },
    --     config = function ()
    --         require("alpha").setup(require"alpha.themes.theta".config)
    --     end
    -- }

    use {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    visual = "s",
                },
                highlight = {
                    duration = 0,
                }
            })
        end,
    }

    use {
        "numToStr/Comment.nvim",
        keys = { "gcc", "gc", "gb" },
        config = function()
            require"Comment".setup()
        end,
    }

    -- file managing , picker etc
    use {
        "kyazdani42/nvim-tree.lua",
        after = "nvim-web-devicons",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require("plugins.configs.nvimtree")
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } },
        config = function()
            require("plugins.configs.telescope")
        end,
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end,

config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}})
