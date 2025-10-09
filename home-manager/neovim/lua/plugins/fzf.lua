return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      "telescope",
      hls = { preview_title = "IncSearch" },
      files = { formatter = "path.filename_first" },
      fzf_colors = {
        -- First existing highlight group will be used
        -- values in 3rd+ index will be passed raw
        -- i.e:  `--color fg+:#010101:bold:underline`
        ["fg+"] = { "fg", { "Comment", "Normal" }, "bold", "underline" },
        -- It is also possible to pass raw values directly
        ["gutter"] = "-1",
      },
    })
    -- calling `setup` is optional for customization
  end,
}
