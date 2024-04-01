local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>o', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fa', function() builtin.find_files({ no_ignore = true }) end, {})
vim.keymap.set('n', '<leader>s', function() builtin.live_grep() end)
