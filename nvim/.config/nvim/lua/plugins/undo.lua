return {
  "mbbill/undotree",
  config = function()
    vim.cmd([[
      let g:undotree_DiffAutoOpen = 1     " auto open diff window
      " let undotree window get focus
      let g:undotree_SetFocusWhenToggle = 1
      " using d instead of days to save some space
      let g:undotree_ShortIndicators = 1
      let g:undotree_WindowLayout = 2     " using layout 2
      let g:undotree_SplitWidth = 32      " undotree window size
      let g:undotree_DiffpanelHeight = 6  " diff window height
      function g:Undotree_CustomMap()
      nmap <buffer> k <plug>UndotreeNextState
      nmap <buffer> j <plug>UndotreePreviousState
      endfunc
      ]])
  end,
  -- use cmdline to toggle
  -- vim.keymap.set("n", "<leader>5", vim.cmd.UndotreeToggle),
}

-- undotree window layout 2
-- +----------+------------------------+
-- |          |                        |
-- |          |                        |
-- | undotree |                        |
-- |          |                        |
-- |          |                        |
-- +----------+------------------------+
-- |                                   |
-- |   diff                            |
-- |                                   |
-- +-----------------------------------+
