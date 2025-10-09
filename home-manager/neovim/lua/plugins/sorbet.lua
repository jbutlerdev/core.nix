return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure servers table exists
      opts.servers = opts.servers or {}
      
      -- Configure Sorbet with proper settings
      opts.servers.sorbet = {
        enabled = true,
        -- Sorbet needs special handling for its command
        on_new_config = function(config, root_dir)
          -- Update the command to include the directory
          -- Sorbet should be run from the project root, not the sorbet directory
          config.cmd = { "srb", "tc", "--lsp", "--disable-watchman", "--dir", "." }
          -- Set the working directory to the project root
          config.cmd_cwd = root_dir
        end,
        -- Custom root directory detection
        root_dir = function(fname)
          local util = require("lspconfig.util")
          
          -- Look for the sorbet directory, but return its parent
          local sorbet_dir = util.root_pattern("sorbet/config")(fname)
          if sorbet_dir then
            return sorbet_dir
          end
          
          -- Alternative patterns
          return util.root_pattern(
            ".sorbet",                -- Hidden sorbet directory
            "Gemfile.lock",           -- Ruby project with dependencies
            "Gemfile",                -- Ruby project
            ".git"                    -- Git root
          )(fname) or vim.fn.getcwd()
        end,
        -- Sorbet file types
        filetypes = { "ruby", "eruby", "rake", "rbi" },
        -- Settings
        settings = {
          sorbet = {
            enabled = true,
          },
        },
      }
      
      -- Keep ruby-lsp for non-Sorbet features (formatting, etc.)
      -- If you want only Sorbet, uncomment the next line:
      -- opts.servers.ruby_lsp = { enabled = false }
      
      return opts
    end,
  },
}