vim.cmd("packadd nvim.undotree")

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


local lsp_format_group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_format_group,
    callback = function(event)
        local client = vim.lsp.get_clients({ bufnr = event.buf })[1]
        if client and client.supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ async = false })
        end
    end,
})
