vim.pack.add({
  {
    src = 'https://github.com/mrcjkb/rustaceanvim',
    version = vim.version.range("v8.*"),
  }
})

vim.pack.add({ "https://github.com/saecki/crates.nvim" })

require('crates').setup({
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  }
})

vim.lsp.config("bacon-ls", {
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 1000,
  }
})

vim.g.rustaceanvim = {
  tools = {
  },

  server = {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end,
    default_settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          enable = false,
        },
        diagnostics = {
          enable = false,
        },
        completion = {
          callable = {
            snippets = "add_parentheses",
          }
        }
      },
    }
  },
}
