-- AstroCore: vim options, keymaps and autocommands.
-- See `:h astrocore` for the full option list.

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      cpp_indent = {
        {
          event = "FileType",
          pattern = { "c", "cpp" },
          desc = "Keep labels at the prevailing indent so typing `:` never dedents the line",
          callback = function()
            vim.opt_local.cinoptions:append "L0"
          end,
        },
      },
    },
  },
}
