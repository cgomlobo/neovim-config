local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })
