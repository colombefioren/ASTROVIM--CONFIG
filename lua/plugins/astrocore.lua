-- AstroCore: vim options, keymaps and autocommands.
-- See `:h astrocore` for the full option list.

-- Debounced autosave. Writes without running format-on-save: formatting on
-- every InsertLeave blocked the editor for the whole formatter run. Explicit
-- saves (<C-s>, <Leader>w, :w) still format.
local autosave_timers = {}
local function autosave(bufnr)
  if autosave_timers[bufnr] then autosave_timers[bufnr]:stop() end
  autosave_timers[bufnr] = vim.defer_fn(function()
    autosave_timers[bufnr] = nil
    if not vim.api.nvim_buf_is_valid(bufnr) then return end
    local bo = vim.bo[bufnr]
    if not bo.modified or bo.buftype ~= "" or bo.readonly or not bo.modifiable then return end
    if vim.api.nvim_buf_get_name(bufnr) == "" then return end
    if vim.api.nvim_get_mode().mode:match "^i" then return end
    vim.api.nvim_buf_call(bufnr, function()
      local previous = vim.b[bufnr].autoformat
      vim.b[bufnr].autoformat = false
      vim.cmd "silent! update"
      vim.b[bufnr].autoformat = previous
    end)
  end, 800)
end

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
          callback = function() vim.opt_local.cinoptions:append "L0" end,
        },
      },
      autosave = {
        {
          event = { "InsertLeave", "TextChanged" },
          desc = "Autosave after edits settle, without formatting",
          callback = function(args) autosave(args.buf) end,
        },
      },
    },
  },
}
