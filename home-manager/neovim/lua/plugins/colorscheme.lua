return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    dim_inactive = true,
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = false },
      keywords = { italic = false },
    },
  },
}

-- return {
--   add github-nvim-theme
--   {
--     "projekt0n/github-nvim-theme",
--     config = function()
--       require("github-theme").setup({
--         options = {
--           dim_inactive = true, -- Non focused panes set to alternative background
--         },
--       })
--     end,
--   },
--
--   Configure LazyVim to load theme
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "github_dark_dimmed",
--     },
--   },
-- }
