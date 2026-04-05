local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<localleader>d", function()
  vim.cmd.RustLsp('debug')
end, {silent = true, buffer = bufnr, desc = "run"})

vim.keymap.set("n", "<localleader>D", function()
  vim.cmd.RustLsp('debuggables')
end, {silent = true, buffer = bufnr, desc = "run menu"})

vim.keymap.set("n", "<localleader>r", function()
  vim.cmd.RustLsp('run')
end, {silent = true, buffer = bufnr, desc = "run"})

vim.keymap.set("n", "<localleader>R", function()
  vim.cmd.RustLsp('runnables')
end, {silent = true, buffer = bufnr, desc = "run menu"})

vim.keymap.set("n", "<localleader>T", function()
  vim.cmd.RustLsp('testables')
end, {silent = true, buffer = bufnr, desc = "testables"})

vim.keymap.set("n", "<localleader>me", function()
  vim.cmd.RustLsp('expandMacro')
end, {silent = true, buffer = bufnr, desc = "expand macro"})

vim.keymap.set("n", "<localleader>mr", function()
  vim.cmd.RustLsp('rebuildProcMacros')
end, {silent = true, buffer = bufnr, desc = "rebuild proc macros"})

vim.keymap.set("n", "<localleader>a", function()
  vim.cmd.RustLsp('codeAction')
end, {silent = true, buffer = bufnr, desc = "code action"})

vim.keymap.set("n", "<localleader>A", function()
  vim.cmd.RustLsp{'hover', 'actions'}
end, {silent = true, buffer = bufnr, desc = "hover action"})

vim.keymap.set("n", "<localleader>e", function()
  vim.cmd.RustLsp('explainError')
end, {silent = true, buffer = bufnr, desc = "explain error"})

vim.keymap.set("n", "<localleader>E", function()
  vim.cmd.RustLsp('relatedDiagnostics')
end, {silent = true, buffer = bufnr, desc = "diagnostics"})
vim.keymap.set("n", "<localleader>oc", function()
  vim.cmd.RustLsp('openCargo')
end, {silent = true, buffer = bufnr, desc = "open cargo"})

vim.keymap.set("n", "<localleader>od", function()
  vim.cmd.RustLsp('openDocs')
end, {silent = true, buffer = bufnr, desc = "open docs"})

vim.keymap.set("n", "<localleader>op", function()
  vim.cmd.RustLsp('parentModule')
end, {silent = true, buffer = bufnr, desc = "open parent module"})

vim.keymap.set("n", "<localleader>f", function()
  vim.cmd.RustLsp('flycheck')
end, {silent = true, buffer = bufnr, desc = "flycheck"})
