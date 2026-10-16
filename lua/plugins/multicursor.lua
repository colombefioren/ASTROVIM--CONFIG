-- VSCode-style multiple cursors: <C-d> on a word adds a cursor at the next match.

---@type LazySpec
return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "User AstroFile",
  config = function()
    local mc = require "multicursor-nvim"
    mc.setup()

    local set = vim.keymap.set
    -- add/skip cursors by matching the word under cursor or the selection
    set({ "n", "x" }, "<C-d>", function() mc.matchAddCursor(1) end, { desc = "Add cursor at next match" })
    set({ "n", "x" }, "<A-d>", function() mc.matchSkipCursor(1) end, { desc = "Skip next match" })
    set({ "n", "x" }, "<C-S-d>", function() mc.matchAddCursor(-1) end, { desc = "Add cursor at previous match" })
    set({ "n", "x" }, "<Leader>ma", mc.matchAllAddCursors, { desc = "Add cursors at all matches" })
    -- add cursors on the lines above/below
    set({ "n", "x" }, "<Leader>mj", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
    set({ "n", "x" }, "<Leader>mk", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
    -- one cursor per selected line / per visual match
    set("x", "<Leader>ml", mc.visualToCursors, { desc = "Cursor on each selected line" })
    set("x", "<Leader>ms", mc.splitCursors, { desc = "Split selection into cursors" })
    set("x", "<Leader>mm", mc.matchCursors, { desc = "Cursors at regex matches in selection" })
    set({ "n", "x" }, "<Leader>mt", mc.toggleCursor, { desc = "Toggle cursor here" })
    set({ "n", "x" }, "<Leader>mr", mc.restoreCursors, { desc = "Restore last cursors" })

    -- only active while cursors exist
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<Left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<Right>", mc.nextCursor)
      layerSet({ "n", "x" }, "<Leader>mx", mc.deleteCursor)
      layerSet("n", "<Esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = { mappings = { n = { ["<Leader>m"] = { desc = "Multicursor" } } } },
    },
  },
}
