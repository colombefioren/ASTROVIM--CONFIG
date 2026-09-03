return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,

      integrations = {
        blink_cmp = true,
        gitsigns = true,
        neotree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
        },
      },
    },
  },
}
