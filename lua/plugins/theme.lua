return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup {
        style = "dark",
        transparent = true,
        italic_comments = true,
        disable_nvimtree_bg = true,
      }

      vim.cmd.colorscheme "vscode"
    end,
  },

  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "vscode",
    },
  },
}
