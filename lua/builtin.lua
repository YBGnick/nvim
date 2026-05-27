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

vim.api.nvim_create_user_command("VimPackClean", function()
  local inactive = vim.iter(vim.pack.get()):filter(function(x) return not x.active end):map(function(x) return x.spec
    .name end):totable()
  if #inactive > 0 then
    vim.pack.del(inactive)
    vim.notify("Deleted: " .. table.concat(inactive, ", "))
  else
    vim.notify("No inactive plugins to clean.")
  end
end, {})
