local function init()

    -- Main setup call with config
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    local cmp = require('cmp')
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({
        max_lines = 2000,
        max_num_results = 40,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = { -- default is not to ignore
            -- uncomment to ignore in lua:
            html = true
        },
        show_prediction_strength = true,
    })

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end
    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end

        },
        formatting = {
            format = lspkind.cmp_format({
                maxwidth = 50,
                mode = 'symbol', -- show only symbol annotations
                with_text = true,
                menu = ({
                    nvim_lsp = "[LSP]",
                    cmp_tabnine = "[TN]",
                    luasnip = "[LuaSnip]",
                    latex_symbols = "[Latex]",
                    nvim_lua = "[Lua]",
                    buffer = "[Buffer]"
                })
            }),
        },
        experimental = {
            ghost_text = true
        },
        mapping = {
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif has_words_before() and luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) == 1 then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<Space>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.close()
                    fallback()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<CR>'] = cmp.mapping(function(fallback)
                if cmp.visible() and cmp.get_selected_entry() ~= nil then
                    cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    cmp.close()
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-k>'] = cmp.mapping.scroll_docs(4),
            ['<C-j>'] = cmp.mapping.scroll_docs(-4),
            ['<C-e>'] = cmp.mapping.close(),
        },
        window = {
            documentation = cmp.config.window.bordered(),
            completion = cmp.config.window.bordered()
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'cmp_tabnine' },
            { name = 'buffer' },
            { name = 'luasnip' }, -- For luasnip users.
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'cmdline' }
        }
    })


end

return {
    init = init
}
