vim.pack.add({
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range("v1.*"),
	}
})
vim.pack.add({'https://github.com/rafamadriz/friendly-snippets'})
vim.pack.add({'https://github.com/onsails/lspkind.nvim'})


require('blink.cmp').setup({
	keymap = {preset = 'super-tab'},
	appearance = {
		nerd_font_variant = 'mono',
	},
	completion = {
		documentation = {auto_show = false},
    trigger = { show_in_snippet = false, },
    ghost_text = {
      enabled = true,
    },
    list = {
      selection = {
        preselect = function(ctx)
          require('blink.cmp').snippet_active({direction = 1})
        end,
      }
    },
    signature = {
      enabled = true,
      show_documentation = false,
    },
    menu = {
      draw = {
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
		default = {'lsp', 'path', 'snippets', 'buffer'},
	},
	fuzzy = {
		implementation = "rust"
	}

})
