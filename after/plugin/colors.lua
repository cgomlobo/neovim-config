local useTheme = "catppuccin"

require('catppuccin').setup({
    color_overrides = {
        mocha = {
            base = "#16191D",
            mantle = "#353b45",
            surface0 = "#3e4451",
            surface1 = "#545862",
            surface2 = "#565c64",
            text = "#abb2bf",
            rosewater = "#b6bdca",
            lavender = "#c8ccd4",
            red = "#e06c75",
            peach = "#d19a66",
            yellow = "#e5c07b",
            green = "#98c379",
            teal = "#56b6c2",
            blue = "#61afef",
            mauve = "#c678dd",
            flamingo = "#be5046",

            -- now patching extra palettes
            maroon = "#e06c75",
            sky = "#d19a66",

            -- extra colors not decided what to do
            pink = "#F5C2E7",
            sapphire = "#74C7EC",

            subtext1 = "#BAC2DE",
            subtext0 = "#A6ADC8",
            overlay2 = "#9399B2",
            overlay1 = "#7F849C",
            overlay0 = "#6C7086",

            crust = "#11111B",
        },
    },
    integrations = {
        nvimtree = true
    }
})

local colorConfigs = {
    monokai = function()
        vim.cmd.highlight({ "Normal", "ctermfg=231", "ctermbg=235", "cterm=NONE", "guifg=#f8f8f2", "guibg=#161616",
            "gui=NONE" })
        vim.cmd.highlight({ "LineNr", "ctermfg=102", "ctermbg=237", "cterm=NONE", "guifg=#90908a", "guibg=#262626",
            "gui=NONE" })
        vim.cmd.highlight({ "SignColumn", "ctermfg=NONE", "ctermbg=237", "cterm=NONE", "guifg=NONE", "guibg=#262626",
            "gui=NONE" })
    end,
    gruvbox = function()
        vim.g.gruvbox_contrast_dark = "hard"
    end
}

local function applyColor(color)
    color = color or "monokai"
    vim.cmd.colorscheme(color)

    local colorConfig = colorConfigs[color]
    if (colorConfig) then colorConfig() end
end

applyColor(useTheme)
