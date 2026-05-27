vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim" })
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })


require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = {
        name = "ollama",
        model = "gemma2:2b"
      },
    },
    inline = {
      adapter = {
        name = "ollama",
        model = "gemma2:2b"
      },
    },
    cmd = {
      adapter = {
        name = "ollama",
        model = "gemma2:2b"
      },
    },
    background = {
      adapter = {
        name = "ollama",
        model = "gemma2:2b"
      },
    }
  }
})
