local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup({
	handlers = {
		["textDocument/publishDiagnostics"] = function() end,
	},
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				autoSearchPaths = true,
				typeCheckingMode = "off",
				useLibraryCodeForTypes = true,
			},
			pythonPath = vim.fn.exepath(".venv/bin/python") or "python",
		},
	},
	capabilities = capabilities,
})

lspconfig.ruff_lsp.setup({
	settings = {
		ruff = {
			path = vim.fn.exepath(".venv/bin/ruff") or "ruff",
		},
	},
	capabilities = capabilities,
})

lspconfig.gopls.setup({})

lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
				experimental = {
					enable = true,
				},
			},
		},
	},
	capabilities = capabilities,
})

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
