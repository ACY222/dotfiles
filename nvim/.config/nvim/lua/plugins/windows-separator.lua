return {
    -- make the active window distinguishable via window separator
    -- color the border of active window
    'nvim-zh/colorful-winsep.nvim',
    config = true,
    event = { 'WinLeave' },
}
