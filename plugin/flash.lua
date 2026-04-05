vim.pack.add({"https://codeberg.org/andyg/leap.nvim"})


vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

vim.keymap.set({ 'x', 'o' }, 'R',  function()
  require('leap.treesitter').select {
    -- To increase/decrease the selection in a clever-f-like manner,
    -- with the trigger key itself (vRRRRrr...). The default keys
    -- (<enter>/<backspace>) also work, so feel free to skip this.
    opts = require('leap.user').with_traversal_keys('R', 'r')
  }
end)

require('leap').opts.preview = function(ch0, ch1, ch2)
  return not (
    ch1:match('%s')
    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
  )
end

-- Enable the traversal keys to repeat the previous search without
-- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
do
  local clever = require('leap.user').with_traversal_keys
  -- For relative directions, set the `backward` flags according to:
  -- local prev_backward = require('leap').state['repeat'].backward
  vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
    require('leap').leap {
      ['repeat'] = true, opts = clever('<cr>', '<bs>'),
    }
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
    require('leap').leap {
      ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
    }
  end)
end

-- Set automatic paste after remote yank operations:
vim.api.nvim_create_autocmd('User', {
  pattern = 'RemoteOperationDone',
  group = vim.api.nvim_create_augroup('LeapRemote', {}),
  callback = function(event)
    if vim.v.operator == 'y' and event.data.register == '"' then
      vim.cmd('normal! p')
    end
  end,
})




