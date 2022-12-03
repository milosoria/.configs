local function init()
    local ok1, tabby = pcall(require, "tabby")
    local ok2, nvim_web_devicons = pcall(require, "nvim-web-devicons")

    if not ok1 or not ok2 then
        print("Failed to load tabby or nvim-web-devicons")
        return
    end
    local colors = {
        vertsplit = "#181A1F",
        special_grey = "#3B4048",
        menu_grey = "#3E4452",
        cursor_grey = "#2C323C",
        gutter_fg_grey = "#4B5263",
        blue = "#82b1ff",
        dark_red = "#BE5046",
        white = "#bfc7d5",
        green = "#C3E88D",
        purple = "#c792ea",
        yellow = "#ffcb6b",
        light_red = "#ff869a",
        red = "#ff5370",
        dark_yellow = "#F78C6C",
        cyan = "#89DDFF",
        comment_grey = "#697098",
        black = "#292D3E",
    }

    local lualine_config = {
        normal = {
            a = { fg = colors.black, bg = colors.purple, gui = "bold" },
            b = { fg = colors.purple, bg = colors.menu_grey },
            c = { fg = colors.comment_grey, bg = colors.black },
        },
        insert = {
            a = { fg = colors.black, bg = colors.blue, gui = "bold" },
            b = { fg = colors.blue, bg = colors.menu_grey },
        },
        visual = {
            a = { fg = colors.black, bg = colors.cyan, gui = "bold" },
            b = { fg = colors.cyan, bg = colors.menu_grey },
        },
        replace = {
            a = { fg = colors.black, bg = colors.green, gui = "bold" },
            b = { fg = colors.green, bg = colors.menu_grey },
        },
        inactive = {
            a = { fg = colors.black, bg = colors.menu_grey, gui = "bold" },
            b = { fg = colors.black, bg = colors.menu_grey },
            c = { fg = colors.black, bg = colors.menu_grey },
        },
    }

    local function tab_label(tabid)
        local focused_win = vim.api.nvim_tabpage_get_win(tabid)
        local filename = require("tabby.filename").tail(focused_win)
        local name = require("tabby.util").get_tab_name(tabid)
        local icon = nvim_web_devicons.get_icon(name, vim.fn.fnamemodify(filename, ":e"))
        local number = vim.api.nvim_tabpage_get_number(tabid)
        return string.format(" %s %d: %s ", icon, number, name)
    end

    tabby.setup({
        tabline = {
            hl = "lualine_c_insert",
            layout = "tab_only",
            head = {
                { "  ", hl = { fg = lualine_config.insert.b.fg, bg = lualine_config.insert.b.bg } },
                { "", hl = { fg = lualine_config.insert.b.bg, bg = lualine_config.normal.c.bg } },
            },
            active_tab = {
                label = function(tabid)
                    return {
                        tab_label(tabid),
                        hl = { fg = lualine_config.insert.a.fg, bg = lualine_config.insert.a.bg, style = "bold" },
                    }
                end,

                left_sep = { "", hl = { fg = lualine_config.insert.a.bg, bg = lualine_config.normal.c.bg } },
                right_sep = { "", hl = { fg = lualine_config.insert.a.bg, bg = lualine_config.normal.c.bg } },
            },
            inactive_tab = {
                label = function(tabid)
                    return {
                        tab_label(tabid),
                        hl = { fg = lualine_config.insert.b.fg, bg = lualine_config.normal.c.bg },
                    }
                end,
                -- ''
                left_sep = { "", hl = { fg = lualine_config.insert.b.bg, bg = lualine_config.normal.c.bg } },
                right_sep = { "", hl = { fg = lualine_config.insert.b.bg, bg = lualine_config.normal.c.bg } },
            },
        },
    })
end

return {
    init = init,
}
