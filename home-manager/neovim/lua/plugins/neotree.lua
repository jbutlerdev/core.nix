return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 40,
    },
    filesystem = {
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every time
      },
      filtered_items = {
        visible = true,
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(_)
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
