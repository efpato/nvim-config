require("bufferline").setup({
	options = {
		mode = "buffers",
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				separator = true,
				padding = 1,
			},
		},
		diagnostics = "nvim_lsp",
		separator_style = "slope",
	},
})
