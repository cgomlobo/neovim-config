vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "BufWinLeave" }, {
    pattern = "*",
    callback = function()
        if (vim.bo.buftype ~= "") then
            return
        end
        vim.api.nvim_command('write')
    end
})
