local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
	{ "phaazon/hop.nvim" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
	},
	{ "nvim-treesitter/nvim-treesitter" },
	{ "neovim/nvim-lspconfig" },
	{ "terrortylor/nvim-comment" },
	{ "Shatur/neovim-ayu" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "williamboman/mason.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "windwp/nvim-autopairs" },
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{
		"linrongbin16/lsp-progress.nvim",
		event = { "VimEnter" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lsp-progress").setup()
		end,
	},
	{ "lewis6991/gitsigns.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{ "folke/which-key.nvim" },
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
})
