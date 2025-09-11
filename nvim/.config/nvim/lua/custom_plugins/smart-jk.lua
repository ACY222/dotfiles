-- smarter j, k
vim.keymap.set( {'n', 'v' }, 'j', function() 
    return vim.v.count > 0 and 'j' or 'gj' end, {expr = true, noremap = true })
vim.keymap.set( {'n', 'v' }, 'k', function() 
    return vim.v.count > 0 and 'k' or 'gk' end, {expr = true, noremap = true })
