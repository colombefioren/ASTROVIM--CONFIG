-- Autopairs: always close quotes and brackets.
-- The defaults refuse to pair when the line already has an unbalanced bracket
-- or when the cursor sits inside a treesitter string/comment node, which is
-- why `(` and `'` only "sometimes" got their partner.

---@type LazySpec
return {
  "windwp/nvim-autopairs",
  opts = {
    check_ts = false,
    enable_check_bracket_line = false,
    ignored_next_char = "[%w]",
    fast_wrap = { map = "<M-e>" },
  },
}
