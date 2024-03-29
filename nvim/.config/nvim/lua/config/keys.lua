-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Horizontal Scrolling with mouse holding Alt
vim.keymap.set({ 'n', 'v' }, "<M-ScrollWheelDown>", "zL", { desc = 'Scroll horizontally to the left' })
vim.keymap.set({ 'n', 'v' }, "<M-ScrollWheelUp>", "zH", { desc = 'Scroll horizontally to the left' })

vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled" }, {
  callback = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    if current_line <= 5 or current_line >= (total_lines - 5) then
      vim.o.scrolloff = 0
    else
      vim.o.scrolloff = 5
    end
  end
})
