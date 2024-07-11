local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})

local lsp_config = require('lspconfig')

-- npm install -g typescript typescript-language-server
lsp_config.tsserver.setup {}

-- pip install -U jedi-language-server
lsp_config.jedi_language_server.setup {}

-- rustup component add rust-analyzer
lsp_config.rust_analyzer.setup {}

-- https://luals.github.io/#neovim-install
lsp_config.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- npm install -g @astrojs/language-server
lsp_config.astro.setup {}

-- npm install -g emmet-ls
lsp_config.emmet_ls.setup {}

--
lsp_config.jsonls.setup {}

-- npm install -g svelte-language-server
lsp_config.svelte.setup {}
