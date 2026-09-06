return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      disable_inlay_hints = {
        {
          event = "LspAttach",
          callback = function(args)
            if vim.lsp.inlay_hint then vim.lsp.inlay_hint.enable(false, { bufnr = args.buf }) end
          end,
          desc = "Disable LSP inlay hints",
        },
      },
    },
  },
}
