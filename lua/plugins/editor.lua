return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
