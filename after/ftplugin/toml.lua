local crates = require("crates")
local opts = { silent = true }

vim.keymap.set("n", "<localleader>t", crates.toggle, opts)
vim.keymap.set("n", "<localleader>r", crates.reload, opts)

vim.keymap.set("n", "<localleader>v", crates.show_versions_popup, opts)
vim.keymap.set("n", "<localleader>f", crates.show_features_popup, opts)
vim.keymap.set("n", "<localleader>d", crates.show_dependencies_popup, opts)

vim.keymap.set("n", "<localleader>u", crates.update_crate, opts)
vim.keymap.set("v", "<localleader>u", crates.update_crates, opts)
vim.keymap.set("n", "<localleader>a", crates.update_all_crates, opts)
vim.keymap.set("n", "<localleader>U", crates.upgrade_crate, opts)
vim.keymap.set("v", "<localleader>U", crates.upgrade_crates, opts)
vim.keymap.set("n", "<localleader>A", crates.upgrade_all_crates, opts)

vim.keymap.set("n", "<localleader>x", crates.expand_plain_crate_to_inline_table, opts)
vim.keymap.set("n", "<localleader>X", crates.extract_crate_into_table, opts)

vim.keymap.set("n", "<localleader>H", crates.open_homepage, opts)
vim.keymap.set("n", "<localleader>R", crates.open_repository, opts)
vim.keymap.set("n", "<localleader>D", crates.open_documentation, opts)
vim.keymap.set("n", "<localleader>C", crates.open_crates_io, opts)
vim.keymap.set("n", "<localleader>L", crates.open_lib_rs, opts)
