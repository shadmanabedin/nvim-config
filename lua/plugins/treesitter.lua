return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "typescript", "tsx", "javascript", "python", "go", "templ" },
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-]>",
					node_incremental = "<C-]>",
					scope_incremental = false,
					node_decremental = "<C-[>",
				},
			},
			autotag = {
				enable = true,
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"jsx",
					"rescript",
					"xml",
					"php",
					"markdown",
					"astro",
					"glimmer",
					"handlebars",
					"hbs",
					"templ",
				},
				skip_tags = {
					"area",
					"base",
					"br",
					"col",
					"command",
					"embed",
					"hr",
					"img",
					"slot",
					"input",
					"keygen",
					"link",
					"meta",
					"param",
					"source",
					"track",
					"wbr",
					"menuitem",
				},
			},
		})
	end,
}
