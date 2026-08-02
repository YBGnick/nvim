vim.pack.add({
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range("v1.*"),
    }
})
vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' })
vim.pack.add({ 'https://github.com/onsails/lspkind.nvim' })




require('blink.cmp').setup({
    keymap = { preset = 'super-tab' },
    appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
        accept = {
            auto_brackets = { enabled = false }
        },
        trigger = { show_in_snippet = false, },
        ghost_text = {
            enabled = true,
        },
        menu = {
            enabled = true,
            draw = {
                treesitter = { "lsp" },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            return require('lspkind').symbol_map[ctx.kind] or ''
                        end,
                    },
                },
            },
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
        },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    }

})
