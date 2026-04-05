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
    default = { 'lsp', 'path', 'snippets', 'dadbod', 'buffer' },
    providers = {
      dadbod = {
        name = "Dadbod",
        module = "vim_dadbod_completion.blink",
        score_offset = 100,

        enabled = function()
          local ft = vim.bo.filetype

          if vim.tbl_contains({ "sql", "mysql", "plsql" }, ft) then
            return true
          end

          if ft == "go" then
            local ok, node = pcall(vim.treesitter.get_node)
            if ok and node then
              return vim.tbl_contains({
                "interpreted_string_literal",
                "raw_string_literal",
                "string_content"
              }, node:type())
            end
          end

          return false
        end,
      },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  }

})
