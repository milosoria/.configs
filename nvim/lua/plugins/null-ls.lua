local function init()
    local ok, null_ls = pcall(require, "null-ls")
    local ok2, lsp_format = pcall(require, "lsp-format")
    if not ok or not ok2 then
        print("Failed to load null_ls or/and lsp-format")
        return
    end
    local formatting = null_ls.builtins.formatting
    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    lsp_format.setup({})

    null_ls.setup({
        sources = {
            formatting.stylua,
            formatting.prettier,
            formatting.eslint_d,
            code_actions.eslint_d,
            diagnostics.eslint_d,
            formatting.rustfmt,
            formatting.ruff,
        },
        on_attach = function(client, _)
            if client.name == "null-ls" then
                lsp_format.on_attach(client)
            end
        end,
    })
end

return {
    init = init,
}
