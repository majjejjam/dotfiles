local present1, autopairs = pcall(require, "nvim-autopairs")
local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

if present1 and present2 then
    local default = { fast_wrap = {}, check_ts = true }
    autopairs.setup(default)

    local cmp = require "cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'
-- local cond = require('nvim-autopairs.conds')
-- local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']'),
  -- Rust
  -- Rule('<', '>', 'rust')
  --     :with_pair(ts_conds.is_ts_node({
  --         'type_identifier',
  --         'let_declaration',
  --         'parameters',
  --     }))
  --     :with_cr(cond.none()),
}
