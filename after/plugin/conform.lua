require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "biome", "prettierd", "prettier" }, stop_after_first = true },
        typescript = { { "biome", "prettierd", "prettier" }, stop_after_first = true },
        javascriptreact = { { "biome", "prettierd", "prettier", stop_after_first = true } },
        typescriptreact = { { "biome", "prettierd", "prettier", stop_after_first = true } },
        json = { "biome" },
        -- Install: rustup component add rustfmt
        rust = { "rustfmt" },
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
