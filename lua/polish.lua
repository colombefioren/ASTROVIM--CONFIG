-- lua/polish.lua
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, grp in ipairs { "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" } do
      vim.api.nvim_set_hl(0, grp, { bg = "none" })
    end
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})
