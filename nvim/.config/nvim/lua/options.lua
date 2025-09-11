local options = {
  ---------- base config ----------
  backup          = false,
  swapfile        = false,
  undofile        = true,
  writebackup     = false,
  fileencoding    = 'utf8',
  termguicolors   = true,
  updatetime      = 100,
  mouse           = 'a',
  splitright      = true,
  splitbelow      = true,
  cursorline      = true,
  number          = true,
  relativenumber  = true,
  signcolumn      = "yes:1",      -- one column for signcolumn
  -- conceallevel    = 0,            -- so that `` is visible in .md files
  cmdheight       = 1,
  tabstop         = 2,
  expandtab       = true,
  shiftwidth      = 2,
  shiftround      = true,
  showtabline     = 2,            -- always show the tab line(tab bar)
  clipboard 	    = "unnamedplus",-- use system clipboard. It realoly works!


  ---------- edit config ----------
  timeoutlen      = 500,
  wrap            = true,
  linebreak       = true,
  textwidth       = 80,
  scrolloff       = 8,
  whichwrap       = "<>[]hl",
  virtualedit     = 'block',      -- virtual edit is allowed in virtual block mode
  foldmethod      = 'indent',
  foldlevel       = 99,
  foldenable      = true,
  foldlevelstart  = 99,
  -- popup menu even there is only one match,
  -- noinsert(no effect if 'longest' is presetn), noselect
  -- if both 'noinsert' and 'noselect' are present, 'noselect' has precedence
  -- show extra informatino about the currently selected completion in a popup
  -- menu, or we can use preview
  completeopt = "menu,menuone,noselect,popup",


  ---------- search config ----------
  hlsearch        = false,
  ignorecase      = true,
  smartcase       = true,
  incsearch       = true,
  showmode        = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- undo file position
vim.cmd([[
    silent !mkdir -p $HOME/.config/nvim/tmp/undo
    set undodir=$HOME/.config/nvim/tmp/undo,.
]])

-- entering insert mode when start a terminal
vim.cmd([[autocmd TermOpen term://* startinsert]])

-- source init.lua after write
vim.cmd([[
    augroup NVIMRC
    autocmd!
    autocmd BufWritePost init.lua exec ":so %"
    augroup END
]])


-- when entering a buffer, set current work directory
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "silent! lcd %:p:h",
})

-- returns to the last edited location when open a file
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
