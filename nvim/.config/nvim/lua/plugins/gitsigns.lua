return {
  'airblade/vim-gitgutter',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.cmd([[
      nmap ]h <Plug>(GitGutterNextHunk)
      nmap [h <Plug>(GitGutterPrevHunk)
      nmap ghs <Plug>(GitGutterStageHunk)
      nmap ghu <Plug>(GitGutterUndoHunk)
      nmap ghp <Plug>(GitGutterPreviewHunk)
      let g:gitgutter_sign_added = '+'
      let g:gitgutter_sign_modified = '~'
      let g:gitgutter_sign_removed = '-'
      let g:gitgutter_sign_removed_first_line = '¯'
      let g:gitgutter_sign_removed_above_and_below = '='
      let g:gitgutter_sign_modified_removed = '~_'
    ]])
  end,
}
