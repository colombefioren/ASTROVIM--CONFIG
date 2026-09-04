return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
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
