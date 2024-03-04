local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<C-k>"] = cmp.mapping.select_next_item(),
		["<C-j>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<C-space>"] = cmp.mapping.complete(),
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer",  keyword_length = 5 },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
			},
		}),
	},
	experimental = {
		ghost_text = true,
	},
})

local luasnip = require("luasnip")
local types = require("luasnip.util.types")
luasnip.config.setup({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<--", "Error" } },
			},
		},
	},
})

