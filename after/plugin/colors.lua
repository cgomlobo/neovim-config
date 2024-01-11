local colorConfigs = {
    monokai = function()
        vim.cmd.highlight({ "Normal", "ctermfg=231", "ctermbg=235", "cterm=NONE", "guifg=#f8f8f2", "guibg=#161616",
            "gui=NONE" })
        vim.cmd.highlight({ "LineNr", "ctermfg=102", "ctermbg=237", "cterm=NONE", "guifg=#90908a", "guibg=#262626",
            "gui=NONE" })
        vim.cmd.highlight({ "SignColumn", "ctermfg=NONE", "ctermbg=237", "cterm=NONE", "guifg=NONE", "guibg=#262626",
            "gui=NONE" })
    end
}

local function applyColor(color)
    color = color or "monokai"
    vim.cmd.colorscheme(color)

    local colorConfig = colorConfigs[color]
    if (colorConfig) then colorConfig() end
end

applyColor()
