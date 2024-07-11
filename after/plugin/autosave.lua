vim.api.nvim_create_autocmd({ "FocusLost" }, {
    pattern = "*",
    callback = function()
        if (vim.bo.buftype ~= "" or vim.fn.expand("%") == "") then
            return
        end
        vim.api.nvim_command('wall')
    end
})
