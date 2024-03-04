require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "python", "rust", "yaml", "json", "toml", "html", "javascript" },

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
