return {
  "rgroli/other.nvim",
  config = function(_, _)
    require("other-nvim").setup({
      mappings = {
        -- builtin mappings
        "livewire",
        "angular",
        "laravel",
        "rails",
        "golang",
      },
      showMissingFiles = false,
    })
  end,
}
