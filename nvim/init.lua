local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.wo.number = true
vim.wo.relativenumber = true
vim.keymap.set("i", "<Tab>", "<Esc>", { noremap = true, silent = true })

require("vim-options")
require("lazy").setup({
	spec = "plugins",
	rocks = {
		hererocks = {
			path = vim.fn.stdpath("data") .. "/lazy-rocks",
		},
	},
})
