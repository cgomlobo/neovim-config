local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })

    if client.supports_method('textDocument/formatting') then
        require('lsp-format').on_attach(client)
    end
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})

-- npm install -g typescript typescript-language-server
require 'lspconfig'.tsserver.setup {}

-- pip install -U jedi-language-server
require 'lspconfig'.jedi_language_server.setup {}

-- rustup component add rust-analyzer
require 'lspconfig'.rust_analyzer.setup {}

-- https://luals.github.io/#neovim-install
require 'lspconfig'.lua_ls.setup {}

-- npm install -g @astrojs/language-server
require 'lspconfig'.astro.setup {}

-- npm install -g @astrojs/language-server
require 'lspconfig'.emmet_ls.setup {}

-- npm install -g svelte-language-server
require 'lspconfig'.svelte.setup {}
