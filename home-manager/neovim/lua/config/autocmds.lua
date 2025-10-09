-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- This doesn't seem to be working, starts disablign cmp for all filetypes
-- after entering markdown buffer.
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "markdown" },
--   callback = function()
--     require("cmp").setup.buffer({
--       enabled = false,
--     })
--   end,
-- })
-- character table string
local N = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function encode_base64(data)
  local data1 = (
    data:gsub(
      ".",
      --- @param x string
      --- @return string
      function(x)
        local r, b = "", x:byte()
        for i = 8, 1, -1 do
          r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
        end
        return r
      end
    ) .. "0000"
  )

  local data2 = data1:gsub(
    "%d%d%d?%d?%d?%d?",
    --- @param x string
    --- @return string
    function(x)
      if #x < 6 then
        return ""
      end
      local c = 0
      for i = 1, 6 do
        c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
      end
      return N:sub(c + 1, c + 1)
    end
  )

  local suffix = ({ "", "==", "=" })[#data % 3 + 1]

  return data2 .. suffix
end

local function osc52_copy(text)
  local text_b64 = encode_base64(text)
  local osc = string.format("%s]52;c;%s%s", string.char(0x1b), text_b64, string.char(0x07))
  io.stderr:write(osc)
end

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    osc52_copy(vim.fn.getreg(vim.v.event.regname))
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.md", "*.json" },
  callback = function()
    vim.cmd("set conceallevel=0")
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
  pattern = { "*.md", "*.json" },
  callback = function()
    vim.cmd("set conceallevel=3")
  end,
})

-- Dev check autocmds for Shopify development
-- Run type-check and tests automatically on save for Ruby/TS/JS files
-- This is supplementary to the plugin configuration
local dev_check_group = vim.api.nvim_create_augroup("DevCheckNotification", { clear = true })

-- Show a notification when entering a file that will be auto-checked
vim.api.nvim_create_autocmd("BufEnter", {
  group = dev_check_group,
  pattern = { "*.rb", "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    -- Only show once per session per file
    local filepath = vim.fn.expand("%:p")
    if not vim.g.dev_check_notified then
      vim.g.dev_check_notified = {}
    end
    if not vim.g.dev_check_notified[filepath] then
      vim.g.dev_check_notified[filepath] = true
      vim.defer_fn(function()
        vim.notify("Dev checks enabled for this file (use <leader>dt to toggle)", vim.log.levels.INFO)
      end, 100)
    end
  end,
})
