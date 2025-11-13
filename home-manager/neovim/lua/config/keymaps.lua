-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize mode
-- Should figure out how to disable during in neotree
vim.keymap.set("n", "<C-e>", function()
  require("smart-splits").start_resize_mode()
end, { desc = "Start smart-split resize mode" })

vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

vim.keymap.set("n", "<C-w>h", require("smart-splits").move_cursor_left, { desc = "Move left" })
vim.keymap.set("n", "<C-w>j", require("smart-splits").move_cursor_down, { desc = "Move down" })
vim.keymap.set("n", "<C-w>k", require("smart-splits").move_cursor_up, { desc = "Move up" })
vim.keymap.set("n", "<C-w>l", require("smart-splits").move_cursor_right, { desc = "Move right" })

vim.keymap.set("n", "<C-w>e", function()
  require("smart-splits").start_resize_mode()
end, { desc = "Start smart-split resize mode" })

-- Moving lines in buffer
vim.keymap.set("n", "<Char-0xAA>", ":m .+1<CR>==", { desc = "allow moving lines in normal" })
vim.keymap.set("n", "<Char-0xAB>", ":m .-2<CR>==", { desc = "allow moving lines in normal" })

vim.keymap.set("i", "<Char-0xAA>", "<Esc>:m .+1<CR>==gi", { desc = "allow moving lines in insert" })
vim.keymap.set("i", "<Char-0xAB>", "<Esc>:m .-2<CR>==gi", { desc = "allow moving lines in insert" })

vim.keymap.set("v", "<Char-0xAA>", ":m '>+1<CR>gv=gv", { desc = "allow moving lines in visual" })
vim.keymap.set("v", "<Char-0xAB>", ":m '<-2<CR>gv=gv", { desc = "allow moving lines in visual" })

-- vim-test
vim.keymap.set("n", "t<C-n>", ":TestNearest<CR>", { desc = "test nearest" })
vim.keymap.set("n", "t<C-f>", ":TestFile<CR>", { desc = "test file" })
vim.keymap.set("n", "t<C-l>", ":TestLast<CR>", { desc = "run last test" })

-- neotree
vim.keymap.set("n", "<leader>fs", ":Neotree reveal<CR>", { desc = "Toggle Neotree" })

-- spectre
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sv", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
vim.keymap.set("v", "<leader>sv", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sV", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})


-- tabs
vim.keymap.set("n", "<leader>i", ":tabprevious<CR>", {
  desc = "previous tab",
})

vim.keymap.set("n", "<leader>o", ":tabNext<CR>", {
  desc = "next tab",
})

-- File path yanking
vim.keymap.set("n", "<leader>yr", function()
  local path = vim.fn.expand("%")
  print("Relative path: " .. path)
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Yank relative file path" })

vim.keymap.set("n", "<leader>ya", function()
  local path = vim.fn.expand("%:p")
  print("Absolute path: " .. path)
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Yank absolute file path" })

vim.keymap.set("n", "<leader>yf", function()
  local path = vim.fn.expand("%:t")
  print("Filename: " .. path)
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Yank filename only" })

vim.keymap.set("n", "<leader>yl", function()
  local path = vim.fn.expand("%") .. ":" .. vim.fn.line(".")
  print("Path with line: " .. path)
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Yank file path with line number" })
