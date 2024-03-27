require("neogen").setup({ snippet_engine = "luasnip" })

vim.api.nvim_set_keymap("n", "<leader>df", ":lua require('neogen').generate({type = 'func'})<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require('neogen').generate({type = 'class'})<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('neogen').generate({type = 'type'})<CR>",
    { noremap = true, silent = true })
