local util = require("lspconfig.util")

-- adds ShowRubyDeps command to show dependencies in the quickfix list.
-- add the `all` argument to show indirect dependencies as well
local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
    local params = vim.lsp.util.make_text_document_params()

    local showAll = opts.args == "all"

    client.request("rubyLsp/workspace/dependencies", params, function(error, result)
      if error then
        print("Error showing deps: " .. error)
        return
      end

      local qf_list = {}
      for _, item in ipairs(result) do
        if showAll or item.dependency then
          table.insert(qf_list, {
            text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),

            filename = item.path,
          })
        end
      end

      vim.fn.setqflist(qf_list)
      vim.cmd("copen")
    end, bufnr)
  end, {
    nargs = "?",
    complete = function()
      return { "all" }
    end,
  })
end

Setup = {
  ruby_lsp = function(_, opts)
    opts.on_attach = function(client, buffer)
      add_ruby_deps_command(client, buffer)
    end
  end,
  sorbet = function(_, opts)
    opts.cmd = { "srb", "tc", "--lsp", "--enable-all-experimental-lsp-features" }
    opts.root_dir = util.root_pattern(".git")
  end,
  -- rubocop = function(_, opts)
  --   opts.cmd = { "rubocop", "--lsp" }
  -- end,
}

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      underline = true,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
    },
    document_highlight = { enabled = false },
    -- LSP Server Settings
    servers = {
      sorbet = { mason = false },
      -- rubocop = { mason = false },
      ruby_lsp = {},
      marksman = {},
    },
    setup = Setup,
  },
}
