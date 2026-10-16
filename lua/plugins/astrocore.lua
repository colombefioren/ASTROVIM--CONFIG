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
    mappings = {
      -- Delete never touches the clipboard. `y` copies, `X` cuts, `d`/`c`/`x` just remove.
      n = {
        ["d"] = { '"_d', desc = "Delete (keep clipboard)" },
        ["dd"] = { '"_dd', desc = "Delete line (keep clipboard)" },
        ["D"] = { '"_D', desc = "Delete to end of line (keep clipboard)" },
        ["c"] = { '"_c', desc = "Change (keep clipboard)" },
        ["cc"] = { '"_cc', desc = "Change line (keep clipboard)" },
        ["C"] = { '"_C', desc = "Change to end of line (keep clipboard)" },
        ["x"] = { '"_x', desc = "Delete char (keep clipboard)" },
        ["X"] = { "d", desc = "Cut to clipboard" },
        ["XX"] = { "dd", desc = "Cut line to clipboard" },

        -- Fast motion / editing
        ["H"] = { "^", desc = "Start of line" },
        ["L"] = { "$", desc = "End of line" },
        ["U"] = { "<C-r>", desc = "Redo" },
        ["<C-z>"] = { "u", desc = "Undo" },
        ["<C-y>"] = { "<C-r>", desc = "Redo" },
        ["<Leader>a"] = { "ggVG", desc = "Select all" },
        ["<Esc>"] = { "<Cmd>nohlsearch<CR><Esc>", desc = "Clear search highlight" },
        ["<C-g>"] = {
          function()
            vim.ui.input({ prompt = "Go to line: " }, function(line)
              if line and line:match "^%d+$" then vim.cmd(line) end
            end)
          end,
          desc = "Go to line",
        },
        ["<C-/>"] = { "gcc", remap = true, desc = "Toggle comment" },
        ["<C-_>"] = { "gcc", remap = true, desc = "Toggle comment" },
        ["<A-J>"] = { "<Cmd>t.<CR>", desc = "Duplicate line down" },
        ["<A-K>"] = { "<Cmd>t.-1<CR>", desc = "Duplicate line up" },
        ["<A-Down>"] = { "<Cmd>m .+1<CR>==", desc = "Move line down" },
        ["<A-Up>"] = { "<Cmd>m .-2<CR>==", desc = "Move line up" },
        ["<A-j>"] = { "<Cmd>m .+1<CR>==", desc = "Move line down" },
        ["<A-k>"] = { "<Cmd>m .-2<CR>==", desc = "Move line up" },

        -- Buffers
        ["<Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader><Leader>"] = { function() require("snacks").picker.buffers() end, desc = "Pick buffer" },
        ["<BS>"] = { "<C-^>", desc = "Last buffer" },
      },
      i = {
        -- Stay in insert mode for the common jumps
        ["<C-c>"] = { "<Esc>", desc = "Leave insert mode" },
        ["<C-e>"] = { "<End>", desc = "End of line" },
        ["<C-a>"] = { "<Home>", desc = "Start of line" },
        ["<C-f>"] = { "<Right>", desc = "Forward one char (skip closing pair)" },
        ["<C-b>"] = { "<Left>", desc = "Back one char" },
        ["<C-BS>"] = { "<C-w>", desc = "Delete word before cursor" },
        ["<C-h>"] = { "<C-w>", desc = "Delete word before cursor" },
        ["<C-Del>"] = { "<C-o>dw", desc = "Delete word after cursor" },
        ["<C-z>"] = { "<C-o>u", desc = "Undo" },
        ["<C-y>"] = { "<C-o><C-r>", desc = "Redo" },
        ["<C-s>"] = { "<Esc><Cmd>w!<CR>", desc = "Save and leave insert mode" },
        ["<C-/>"] = { "<C-o>gcc", remap = true, desc = "Toggle comment" },
        ["<C-_>"] = { "<C-o>gcc", remap = true, desc = "Toggle comment" },
        ["<A-J>"] = { "<Cmd>t.<CR>", desc = "Duplicate line down" },
        ["<A-K>"] = { "<Cmd>t.-1<CR>", desc = "Duplicate line up" },
        ["<A-Down>"] = { "<Cmd>m .+1<CR><C-o>==", desc = "Move line down" },
        ["<A-Up>"] = { "<Cmd>m .-2<CR><C-o>==", desc = "Move line up" },
        ["<A-j>"] = { "<Cmd>m .+1<CR><C-o>==", desc = "Move line down" },
        ["<A-k>"] = { "<Cmd>m .-2<CR><C-o>==", desc = "Move line up" },
      },
      x = {
        ["d"] = { '"_d', desc = "Delete (keep clipboard)" },
        ["D"] = { '"_D', desc = "Delete lines (keep clipboard)" },
        ["c"] = { '"_c', desc = "Change (keep clipboard)" },
        ["x"] = { '"_x', desc = "Delete (keep clipboard)" },
        ["X"] = { "d", desc = "Cut to clipboard" },
        ["p"] = { "P", desc = "Paste over selection (keep clipboard)" },
        ["H"] = { "^", desc = "Start of line" },
        ["L"] = { "$", desc = "End of line" },
        ["<C-/>"] = { "gc", remap = true, desc = "Toggle comment" },
        ["<C-_>"] = { "gc", remap = true, desc = "Toggle comment" },
        ["<A-Down>"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
        ["<A-Up>"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },
        ["<A-j>"] = { ":m '>+1<CR>gv=gv", desc = "Move selection down" },
        ["<A-k>"] = { ":m '<-2<CR>gv=gv", desc = "Move selection up" },
      },
      o = {
        ["H"] = { "^", desc = "Start of line" },
        ["L"] = { "$", desc = "End of line" },
      },
    },
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
