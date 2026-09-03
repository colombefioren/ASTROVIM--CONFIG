---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--query-driver=/run/current-system/sw/bin/gcc",
  },
  init_options = {
    fallbackFlags = {
      "--target=x86_64-unknown-linux-gnu",
    },
  },
}
