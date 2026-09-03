---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--query-driver=/run/current-system/sw/bin/gcc",
  },
}
