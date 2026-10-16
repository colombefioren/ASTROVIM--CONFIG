-- lua/polish.lua
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, grp in ipairs { "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" } do
      vim.api.nvim_set_hl(0, grp, { bg = "none" })
    end
  end,
})

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
