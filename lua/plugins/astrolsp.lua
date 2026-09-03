---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = true,
      semantic_tokens = true,
    },

    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = {
          "markdown",
          "text",
        },
      },

      disabled = {
        "lua_ls",
      },

      timeout_ms = 2000,
    },

    servers = {},

    config = {},

    handlers = {},

    mappings = {
      n = {
        gD = {
          function()
            vim.lsp.buf.declaration()
          end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },

        ["<Leader>uY"] = {
          function()
            require("astrolsp.toggles").buffer_semantic_tokens()
          end,
          desc = "Toggle semantic highlights",
          cond = function(client)
            return client:supports_method("textDocument/semanticTokens/full")
              and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },

    on_attach = function(client, bufnr)
      -- Keep LSP semantic highlighting enabled.
    end,
  },
}
