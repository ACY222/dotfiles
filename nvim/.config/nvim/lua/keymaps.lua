vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local ov = { "v", "o" }
local insert = { "i" }
local mappings = {
    ---------- basic ----------
    { from = "S", to = ":w<cr>" },
    { from = "Q", to = ":q<cr>" },
    { from = "jk", to = "<esc>", mode = insert },

    ---------- edit ----------
    { from = "H", to = "^", mode = ov },
    { from = "L", to = "$", mode = ov },

    -- emacs like editing keymap, these will interfere with dot operation
    -- <C-c> quit insert mode
    -- <C-i> insert a tab
    -- <C-j>/<C-m> start new line
    -- <C-t>/<C-d> indent/unindent in insert mode
    -- <C-r> {register} enter the content in register
    { from = "<C-a>", to = "<C-o>^", mode = insert }, -- goto the begining of the line
    { from = "<C-e>", to = "<C-o>$", mode = insert }, -- goto the end of the line
    { from = "<C-b>", to = "<Left>", mode = insert }, -- a character backward
    { from = "<C-f>", to = "<Right>", mode = insert }, -- a character forward
    -- { from = "<C-p>", to = "<Up>", mode = insert },
    { from = "<C-n>", to = "<Down>", mode = insert },

    -- edit the next placeholder in normal mode
    {
        from = "<leader><leader>",
        to = function()
            vim.fn.search("<++>")
            vim.api.nvim_feedkeys('"_c4l', "n", false)
        end,
    },

    -- edit the configuration files
    { from = "<leader>vim", to = ":e ~/.config/nvim/lua/" },

    -- change window size
    { from = "<C-h>", to = "<C-w><" },
    { from = "<C-j>", to = "<C-w>-" },
    { from = "<C-k>", to = "<C-w>+" },
    { from = "<C-l>", to = "<C-w>>" },
    -- switch between windows
    { from = "<S-h>", to = "<C-w>h" },
    { from = "<S-j>", to = "<C-w>j" },
    { from = "<S-k>", to = "<C-w>k" },
    { from = "<S-l>", to = "<C-w>l" },

    ---------- buffer management ----------
    -- why not use <Tab> and <S-Tab> instead?
    { from = "<leader>n", to = ":bn<cr>" },
    { from = "<leader>p", to = ":bp<cr>" },
    { from = "<leader>d", to = ":bd<cr>" },

    ---------- terminal ----------
    -- In terminal, when you can enter commands, you are in terminal mode
    -- when you can move your cursor freely, you are in normal mode
    -- use Esc to return to normal mode(jk to return to vi-cmd-mode)
    { from = "jk", to = "<C-\\><C-N>", mode = "t" },
    -- use ' d' to close terminal in terminal mode
    -- use Q to quit in normal mode
    { from = "<leader>d", to = "exit<CR>", mode = "t" },
    { from = "p", to = '"_dP', mode = "x" },

    -- { from = '<++>', to = '<++>', <++> },
    -- { from = '<++>', to = '<++>', <++> },
}

-- use Vterm to create a term, must begin with an uppercase letter
vim.api.nvim_create_user_command("Vterm", "vsp | terminal", {})

for _, mapping in ipairs(mappings) do
    vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true, silent = true })
end

-- Markdown & Typst keymaps config
local my_docs_group = vim.api.nvim_create_augroup("Documents Keymaps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "types" },
    group = my_docs_group,
    callback = function()
        local opts = { buffer = true, silent = true, noremap = true }
        vim.keymap.set("i", "¥", "$$<left>", opts) -- enable $$ in Chinese mode
        vim.keymap.set("i", "·", "``<left>", opts) -- enable `` in Chinese mode
        vim.keymap.set("i", ",.", "- [ ] ", opts) -- check mark
        vim.keymap.set("n", " m", "/]<CR>hrx", opts) -- finish check mark
    end,
})

-- Highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
