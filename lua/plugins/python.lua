-- Python diagnostics: one type checker, not four.
-- Mason auto-enables every installed language server, so basedpyright, pyrefly,
-- ty and ruff were all attaching to Python buffers and each reported its own
-- copy of every diagnostic. Keep basedpyright for type checking and ruff for
-- formatting only.

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    handlers = {
      pyrefly = false,
      ty = false,
    },
    config = {
      ruff = {
        init_options = {
          settings = {
            lint = { enable = false },
          },
        },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                -- LeetCode-style snippets reference classes (ListNode, TreeNode)
                -- that only exist in the judge. Keep it visible, not an error.
                reportUndefinedVariable = "warning",
                reportMissingImports = "warning",
                reportAttributeAccessIssue = "warning",
                reportArgumentType = "warning",
                reportCallIssue = "warning",
                reportIndexIssue = "warning",
                reportOperatorIssue = "warning",
                reportReturnType = "warning",
              },
            },
          },
        },
      },
    },
  },
}
