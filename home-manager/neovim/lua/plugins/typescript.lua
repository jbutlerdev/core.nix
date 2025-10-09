-- Disable TypeScript server formatting in favor of Prettier
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        settings = {
          typescript = {
            format = {
              enable = false, -- Disable tsserver formatting
            },
          },
          javascript = {
            format = {
              enable = false, -- Disable tsserver formatting
            },
          },
        },
      },
    },
  },
}