return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      local builtin = require("telescope.builtin")
      require("telescope").load_extension("fzf")

      -- general file finder
      if vim.fn.getcwd() == os.getenv("HOME") or string.find(vim.fn.getcwd(), "Shopify/shopify") then
        -- fzf as alternative for the home directoy, as telescope is very slow there
        vim.keymap.set("n", "<LEADER>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
      else
        function custom_find_files()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          if vim.v.shell_error == 0 then
            builtin.git_files()
          else
            builtin.find_files({
              find_command = { "rg", "--files", "--hidden", "--ignore" },
            })
          end
        end

        vim.keymap.set("n", "<LEADER>ff", custom_find_files, {})
      end
    end,
  },
  opts = {
    defaults = {
      path_display = {
        filename_first = {
          reverse_directories = false,
        },
      },
    },
    -- defaults = vim.tbl_extend(
    --   "force",
    --   require("telescope.themes").get_dropdown(), -- or get_cursor, get_ivy
    --   {
    --     path_display = filenameFirst,
    --     layout_config = {
    --       height = 0.5,
    --       width = 0.9,
    --       preview_cutoff = 0,
    --     },
    --   }
    -- ),
    -- pickers = {
    --   find_files = {
    --     theme = "dropdown",
    --   },
    --   live_grep = {
    --     theme = "dropdown",
    --   },
    --   buffers = {
    --     theme = "dropdown",
    --   },
    --   lsp_references = {
    --     theme = "dropdown",
    --   },
    -- },
  },
}
