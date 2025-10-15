local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Python
		-- null_ls.builtins.formatting.black.with({
		-- 	condition = function()
		-- 		return vim.fn.filereadable(".venv/bin/black") > 0
		-- 	end,
		-- 	prefer_local = ".venv/bin",
		-- }),
		-- null_ls.builtins.formatting.isort.with({
		-- 	condition = function()
		-- 		return vim.fn.filereadable(".venv/bin/isort") > 0
		-- 	end,
		-- 	prefer_local = ".venv/bin",
		-- }),
		null_ls.builtins.diagnostics.mypy.with({
			condition = function()
				return vim.fn.filereadable(".venv/bin/mypy") > 0
			end,
			prefer_local = ".venv/bin",
		}),
		-- null_ls.builtins.diagnostics.pylint.with({
		-- 	condition = function()
		-- 		return vim.fn.filereadable(".venv/bin/pylint") > 0
		-- 	end,
		-- 	prefer_local = ".venv/bin",
		-- }),

		null_ls.builtins.code_actions.refactoring,

		-- -- Go
		null_ls.builtins.formatting.gofmt,
	},
	on_attach = function(client, bufnr)
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					-- vim.lsp.buf.formatting_sync()
					vim.lsp.buf.format({
						bufnr = bufnr,
						-- filter = function(client)
						-- 	return client.name == "null-ls"
						-- end,
					})
					if vim.bo.ft == "python" then
						vim.lsp.buf.code_action({
							context = { only = { "source.fixAll.ruff" } },
							apply = true,
						})
					end
				end,
			})
		end
	end,
})
