local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Python
		null_ls.builtins.formatting.black.with({
			condition = function()
				return vim.fn.filereadable(".venv/bin/black") > 0
			end,
			prefer_local = ".venv/bin",
		}),
		null_ls.builtins.formatting.isort.with({
			condition = function()
				return vim.fn.filereadable(".venv/bin/isort") > 0
			end,
			prefer_local = ".venv/bin",
		}),
		null_ls.builtins.formatting.ruff.with({
			condition = function()
				return vim.fn.filereadable(".venv/bin/ruff") > 0
			end,
			prefer_local = ".venv/bin",
		}),
		null_ls.builtins.diagnostics.mypy.with({
			condition = function()
				return vim.fn.filereadable(".venv/bin/mypy") > 0
			end,
			prefer_local = ".venv/bin",
		}),
		null_ls.builtins.diagnostics.pylint.with({
			condition = function()
				return vim.fn.filereadable(".venv/bin/pylint") > 0
			end,
			prefer_local = ".venv/bin",
		}),

		-- Rust
		null_ls.builtins.formatting.rustfmt,

		null_ls.builtins.code_actions.refactoring,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						-- filter = function(client)
						-- 	return client.name == "null-ls"
						-- end,
					})
				end,
			})
		end
	end,
})
