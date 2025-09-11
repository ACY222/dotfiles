-- solve leetcode problems in neovim
-- You need to copy the cookies from the leetcode
--  just copy the value of Cookie of the website in safari
return {
  "kawre/leetcode.nvim",
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  build = ":LeetInstall",
  config = function()
    require("leetcode").setup({
    })
  end,
}
