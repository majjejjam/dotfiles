local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
    return
end

-- alt+<space>, alt+p -> swap next
-- alt+<backspace>, alt+p -> swap previous
-- swap_previous = {
--   ["<M-s><M-P>"] = "@parameter.inner",
--   ["<M-s><M-F>"] = "@function.outer",
-- },
local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    e = "@element",

    -- Not ready, but I think it's my fault :)
    -- v = "@variable",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<M-Space><M-%s>", key)] = obj
    p[string.format("<M-BS><M-%s>", key)] = obj
  end

  return n, p
end)()

ts_config.setup({
    ensure_installed = {
        "lua",
        "vim",
        -- "norg",
        "markdown",
        "markdown_inline",
        "toml",
        -- "latex",
    },
    highlight = {
        enable = true,
        use_languagetree = false,
	disable = { "latex" },
        additional_vim_regex_highlighting = { "markdown", "latex" }, -- spellsitter (is no more) doesn't work when enabled
    },
    indent = {
        enable = true,
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
                ["]p"] = "@parameter.inner",
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[p"] = "@parameter.inner",
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },

        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",

                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",

                ["av"] = "@variable.outer",
                ["iv"] = "@variable.inner",
            },
        },

        swap = {
            enable = true,
            swap_next = swap_next,
            swap_previous = swap_prev,
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
            node_incremental = "<M-w>", -- increment to the upper named parent
            node_decremental = "<M-C-w>", -- decrement to the previous node
            scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
        },
    },
})
