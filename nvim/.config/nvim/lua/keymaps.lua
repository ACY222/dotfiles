vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local nv = { 'n', 'v' }
local ov = { 'v', 'o' }
local ic = { 'i', 'c' }
local visual = { 'v' }
local insert = { 'i' }
local mappings = {
  ---------- basic ----------
  { from = 'S',                to = ':w<cr>' },
  { from = 'Q',                to = ':q<cr>' },
  { from = 'jk',               to = '<esc>',                  mode = insert },

  ---------- edit ----------
  { from = 'H',                to = '^',                      mode = ov },
  { from = 'L',                to = '$',                      mode = ov },

  -- emacs like editing keymap
  -- <C-c> quit insert mode
  -- <C-i> insert a tab
  -- <C-j>/<C-m> start new line
  -- <C-t>/<C-d> indent/unindent in insert mode
  -- <C-r> {register} enter the content in register
  { from = '<C-a>',            to = '<Esc>I',                 mode = insert },  -- goto the begining of the line
  { from = '<C-e>',            to = '<Esc>A',                 mode = insert },  -- goto the end of the line
  { from = '<C-b>',            to = '<Left>',                 mode = insert },  -- a character backward
  { from = '<C-f>',            to = '<Right>',                mode = insert },  -- a character forward
  -- edit the next placeholder in normal mode
  { from = '<leader><leader>', to = function()
    vim.fn.search('<++>')
    vim.api.nvim_feedkeys('"_c4l', 'n', false)
  end
  },

  -- edit the configuration files
  { from = '<leader>vim',      to = ':e ~/.config/nvim/lua/'},

  -- change window size
  { from = '<C-h>', to = '<C-w><' },
  { from = '<C-j>', to = '<C-w>-' },
  { from = '<C-k>', to = '<C-w>+' },
  { from = '<C-l>', to = '<C-w>>' },
  -- switch between windows
  { from = '<S-h>', to = '<C-w>h' },
  { from = '<S-j>', to = '<C-w>j' },
  { from = '<S-k>', to = '<C-w>k' },
  { from = '<S-l>', to = '<C-w>l' },

  ---------- buffer management ----------
  -- why not use <Tab> and <S-Tab> instead?
  { from = '<leader>n', to = ':bn<cr>' },
  { from = '<leader>p', to = ':bp<cr>' },
  { from = '<leader>d', to = ':bd<cr>' },

  ---------- terminal ----------
  -- In terminal, when you can enter commands, you are in terminal mode
  -- when you can move your cursor freely, you are in normal mode
  -- use Esc to return to normal mode(jk to return to vi-cmd-mode)
  { from = 'jk', to = '<C-\\><C-N>', mode = 't' },
  -- use ' d' to close terminal in terminal mode
  -- use Q to quit in normal mode
  { from = '<leader>d', to = 'exit<CR>', mode = 't' },

  -- { from = '<++>', to = '<++>', <++> },
  -- { from = '<++>', to = '<++>', <++> },
}

-- use Vterm to create a term, must begin with an uppercase letter
vim.api.nvim_create_user_command('Vterm', 'vsp | terminal', {})

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to,
    { noremap = true, silent = true })
end

-- Markdown keymaps config
local markdown_group = vim.api.nvim_create_augroup('MarkdownKeymaps', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  group = markdown_group,
  callback = function()
    local opts = { buffer = true, silent = true, noremap = true, }
    vim.keymap.set('i', ',r', '<++>', opts)                     -- create placeholder
    vim.keymap.set('i', ',i', '**<left>', opts)          -- italic
    vim.keymap.set('i', ',b', '****<left><left>', opts)       -- bold
    vim.keymap.set('i', ',s', '~~~~<left><left>', opts)       -- sliced
    vim.keymap.set('i', ',c', '```<Enter><++><Enter>```<Enter><Esc>2kA', opts)  -- big code block

    vim.keymap.set('i', ',m', '- [ ] ', opts)                   -- check mark
    vim.keymap.set('n', ' m', '/]<CR>hrx', opts)                -- finish mark

    vim.keymap.set('i', ',p', '![](<++>) <++><Esc>F[a', opts)   -- picture
    vim.keymap.set('i', ',l', '[](<++>) <++><Esc>F[a', opts)    -- link
    vim.keymap.set('i', ',1', '#<Space><Enter><Enter><++><Enter><Esc>3kA', opts)
    vim.keymap.set('i', ',2', '##<Space><Enter><Enter><++><Enter><Esc>3kA', opts)
    vim.keymap.set('i', ',3', '###<Space><Enter><Enter><++><Enter><Esc>3kA', opts)
    vim.keymap.set('i', ',4', '####<Space><Enter><Enter><++><Enter><Esc>3kA', opts)
  end,
})

-- Highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function ()
    vim.highlight.on_yank()
  end,
})
