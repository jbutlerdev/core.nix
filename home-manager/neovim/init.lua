-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Pre-lazy options (from your personal config)
vim.g["test#strategy"] = "wezterm"
vim.g["test#wezterm#split_direction"] = "bottom"
vim.o.updatetime = 250
vim.opt.swapfile = false
vim.opt.cmdheight = 1
vim.opt.relativenumber = false

-- Load LazyVim configuration
require("config.lazy")