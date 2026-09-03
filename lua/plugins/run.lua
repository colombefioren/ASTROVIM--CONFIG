return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<F6>"] = {
          function()
            local file = vim.fn.expand "%:p"
            local ft = vim.bo.filetype

            local commands = {
              python = "python " .. vim.fn.shellescape(file),
              c = "gcc " .. vim.fn.shellescape(file) .. " -o /tmp/nvim_run && /tmp/nvim_run",
              cpp = "g++ " .. vim.fn.shellescape(file) .. " -o /tmp/nvim_run && /tmp/nvim_run",
              javascript = "node " .. vim.fn.shellescape(file),
              typescript = "npx tsx " .. vim.fn.shellescape(file),
              java = "java " .. vim.fn.shellescape(file),
            }

            local command = commands[ft]

            if not command then
              vim.notify("No run command configured for filetype: " .. ft, vim.log.levels.WARN)
              return
            end

            vim.cmd("botright split | terminal " .. command)
          end,
          desc = "Run current file",
        },
      },
    },
  },
}
