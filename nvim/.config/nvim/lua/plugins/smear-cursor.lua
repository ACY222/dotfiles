return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    smear_between_neighbor_lines = true,
    -- only smear when moving at least these distances
    min_horizontal_distance_smear = 5,
    min_vertical_distance_smear = 5,

    -- Smear cursor in insert mode.
    smear_insert_mode = true,
    -- Stop animating when the smear's tail is within this distance (in characters) from the target.
    distance_stop_animating_vertical_bar = 10,
    -- if the cursor is vertical bar in insert mode
    vertical_bar_cursor_insert_mode = true,

    -- Smear cursor color. Defaults to Cursor GUI color if not set.
    -- Set to "none" to match the text color at the target cursor position.
    cursor_color = "none",
    -- works better in transparent background
    transparent_bg_fallback_color = "#303030",
    -- fix the cursor getting duplicated
    hide_target_hack = true,
    never_draw_over_target = true,

    -- faster smear
    stiffness = 0.8,                      -- 0.6      [0, 1]
    trailing_stiffness = 0.5,             -- 0.4      [0, 1]
    stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    damping = 0.8,                        -- 0.65     [0, 1]
    damping_insert_mode = 0.8,            -- 0.7      [0, 1]
    distance_stop_animating = 0.5,        -- 0.1      > 0
  },
}
