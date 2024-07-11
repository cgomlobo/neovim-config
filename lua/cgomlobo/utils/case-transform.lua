function getSelection()
    local s_buf, s_row, s_col, _ = unpack(vim.fn.getpos("'<"))
    local _, e_row, e_col, _ = unpack(vim.fn.getpos("'>"))
    return vim.api.nvim_buf_get_text(s_buf, s_row - 1, s_col - 1, e_row - 1, e_col - 1, {})[1]
end

function setSelection(text)
    local s_buf, s_row, s_col, _ = unpack(vim.fn.getpos("'<"))
    local _, e_row, e_col, _ = unpack(vim.fn.getpos("'>"))
    return vim.api.nvim_buf_set_text(s_buf, s_row - 1, s_col - 1, e_row - 1, e_col - 1, { text })
end

local function commonCase(text)
    return text:gsub("[_%s%-]+", " "):gsub("(%a)(%u)", function(first, rest)
        return first .. " " .. rest:lower()
    end)
end

function ToPascalCase(text)
    local partial = commonCase(text):gsub("%s(%l)", function(letter) return " " .. letter:upper() end):gsub("%s", "")
    return partial:sub(1, 1):upper() .. partial:sub(2)
end

vim.keymap.set("v", "<leader>tp", [[d:lua vim.fn.setreg("\"", ToPascalCase(vim.fn.getreg("\"")))<CR>P]])

function ToCamelCase(text)
    local partial = commonCase(text):gsub("%s(%l)", function(letter) return " " .. letter:upper() end):gsub("%s", "")
    return partial:sub(1, 1):lower() .. partial:sub(2)
end

vim.keymap.set("v", "<leader>tc", [[d:lua vim.fn.setreg("\"", ToCamelCase(vim.fn.getreg("\"")))<CR>P]])

function ToKebabCase(text)
    local partial = commonCase(text):gsub("%s(%u)", function(letter) return " " .. letter:lower() end):gsub("%s", "-")
    return partial:sub(1, 1):lower() .. partial:sub(2)
end

vim.keymap.set("v", "<leader>tk", [[d:lua vim.fn.setreg("\"", ToKebabCase(vim.fn.getreg("\"")))<CR>P]])

function ToSnakeCase(text)
    local partial = commonCase(text):gsub("%s(%u)", function(letter) return " " .. letter:lower() end):gsub("%s", "_")
    return partial:sub(1, 1):lower() .. partial:sub(2)
end

vim.keymap.set("v", "<leader>ts", [[d:lua vim.fn.setreg("\"", ToSnakeCase(vim.fn.getreg("\"")))<CR>P]])

function ToUppercaseSnakeCase(text)
    return commonCase(text):gsub("%s(%u)", function(letter) return " " .. letter:lower() end):gsub("%s", "_"):upper()
end

vim.keymap.set("v", "<leader>tu", [[d:lua vim.fn.setreg("\"", ToUppercaseSnakeCase(vim.fn.getreg("\"")))<CR>P]])
