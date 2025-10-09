-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g["test#strategy"] = "wezterm"
vim.g["test#wezterm#split_direction"] = "bottom"
vim.o.updatetime = 250
vim.opt.swapfile = false
vim.opt.cmdheight = 1
vim.opt.relativenumber = false
