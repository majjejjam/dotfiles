local present, luasnip = pcall(require, "luasnip")
if present then
    local default = {
        history = false,
        enable_autosnippets = true,
        updateevents = "TextChanged,TextChangedI",
    }
    luasnip.config.set_config(default)
end
require("luasnip.loaders.from_vscode").lazy_load()
