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
lsp_config.ts_ls.setup {}

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

-- npm i -g vscode-langservers-extracted
lsp_config.kotlin_language_server.setup {}

local function bemol()
    local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory' })[1]
    local ws_folders_lsp = {}
    if bemol_dir then
        local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line)
            end
            file:close()
        end
    end

    for _, line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end

lsp_config.jdtls.setup { on_attach = function() bemol() end }
