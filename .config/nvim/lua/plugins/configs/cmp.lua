local present, cmp = pcall(require, "cmp")
local luasnip = require("luasnip")

if not present then
    return
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
    snippet = {
	expand = function(args)
	    require("luasnip").lsp_expand(args.body)
	end,
    },
    experimental = {
	ghost_text = true
    },
    window = {
	completion = cmp.config.window.bordered(),
	documentation = cmp.config.window.bordered(),
    },
    formatting = {
	format = function(entry, vim_item)
	    local icons = require "plugins.configs.lspkind_icons"
	    vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

	    vim_item.menu = ({
		nvim_lsp = "[LSP]",
		nvim_lua = "[Lua]",
		buffer = "[BUF]",
	    })[entry.source.name]

	    return vim_item
	end,
    },
    mapping = {
	["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
	["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
	["<C-d>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-e>"] = cmp.mapping.abort(),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-y>"] = cmp.mapping(
	    cmp.mapping.confirm {
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	    },
	    { "i", "c" }
	),
	-- ["<tab>"] = cmp.config.disable,
	-- ["<CR>"] = cmp.mapping.confirm {
	--     -- behavior = cmp.ConfirmBehavior.Replace,
	--     select = true,
	-- },
	-- ["<Tab>"] = cmp.mapping(function(fallback)
	--    if cmp.visible() then
	--       cmp.select_next_item()
	--    else
	--       fallback()
	--    end
	-- end, { "i", "s" }),
	-- ["<S-Tab>"] = cmp.mapping(function(fallback)
	--    if cmp.visible() then
	--       cmp.select_prev_item()
	--    else
	--       fallback()
	--    end
	-- end, { "i", "s" }),
	["<tab>"] = cmp.mapping(function(fallback)
	    if luasnip.expand_or_jumpable() and has_words_before() then
		luasnip.expand_or_jump()
	    else
		fallback()
	    end
	    end, { "i", "s" }),
	["<S-tab>"] = cmp.mapping(function(fallback)
	    if luasnip.jumpable(-1)and has_words_before()  then
		luasnip.jump(-1)
	    else
		fallback()
	    end
	    end, { "i", "s" }),
    },
    sources = {
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "buffer", keyword_length = 5 },
	{ name = "nvim_lua" },
	{ name = "neorg" },
	{ name = "path" },
	{ name = "plugins" },
	{ name = "dictionary", keyword_length = 2 },
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
	{ name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
	{ name = 'path' }
    }, {
	    { name = 'cmdline' }
	})
})

require("cmp_dictionary").setup({
    dic = {
	["*"] = { "/usr/share/dict/words" },
	["lua"] = "path/to/lua.dic",
	["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
	filename = {
	    ["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
	},
	filepath = {
	    ["%.tmux.*%.conf"] = "path/to/tmux.dic"
	},
	spelllang = {
	    en = "path/to/english.dic",
	},
    },
    -- The following are default values.
    exact = 2,
    first_case_insensitive = false,
    document = false,
    document_command = "wn %s -over",
    async = false,
    capacity = 5,
    debug = false,
})
