local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.4

require("nvim-tree").setup({
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local opts = function(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local git_add = function()
            local node = api.tree.get_node_under_cursor()
            local gs = node.git_status.file

            -- If the current node is a directory get children status
            if gs == nil then
                gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
                    or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
            end

            -- If the file is untracked, unstaged or partially staged, we stage it
            if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
                vim.cmd("silent !git add " .. node.absolute_path)

                -- If the file is staged, we unstage
            elseif gs == "M " or gs == "A " then
                vim.cmd("silent !git restore --staged " .. node.absolute_path)
            end

            api.tree.reload()
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "t", api.tree.toggle_gitignore_filter, opts('Toggle git filter'))
        vim.keymap.set('n', 'ga', git_add, opts('Git Add'))
    end,
    view = {
        float = {
            enable = true,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2)
                    - vim.opt.cmdheight:get()
                return {
                    border = "rounded",
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
        width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
    }
})

local nvimTreeFocusOrToggle = function()
    local nvimTree = require("nvim-tree.api")
    local currentBuf = vim.api.nvim_get_current_buf()
    local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
    if currentBufFt == "NvimTree" then
        nvimTree.tree.toggle()
    else
        nvimTree.tree.focus()
    end
end


vim.keymap.set("n", "<leader>n", nvimTreeFocusOrToggle)
