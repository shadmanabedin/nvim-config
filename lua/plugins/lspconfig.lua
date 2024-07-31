return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = { "black", "stylua", "eslint_d", "prettier" },
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "pyright", "tailwindcss", "gopls", "templ" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.pyright.setup({})
			lspconfig.tailwindcss.setup({})
			lspconfig.gopls.setup({})
			lspconfig.templ.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			vim.filetype.add({ extension = { templ = "templ" } })
		end,
	},
}
