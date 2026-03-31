return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
    --  Usage:
    --      Old text                    Command         New text
    -- -----------------------------------------------------------------------
    --      remove <b>HTML t*ags</b>    dst             remove HTML tags
    --      <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    --      delete(functi*on calls)     dsf             function calls
    --      |in visual mode|            S*              *in visual mode*
    --      in in*sert mode             <C-g>s}         in in{}sert mode
}
