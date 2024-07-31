require("luasnip.session.snippet_collection").clear_snippets("all")
require("luasnip.session.snippet_collection").clear_snippets("rust")
require("luasnip.session.snippet_collection").clear_snippets("typescriptreact")

local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-h>"] = cmp.mapping.confirm({
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

local ls = require("luasnip")
local types = require("luasnip.util.types")
ls.config.setup({
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

vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)

vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set("n", "<leader>so", "<cmd>source ~/.config/nvim/lua/completions.lua<CR>")

local s, i, t, c, f, sn, d =
	ls.s, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node, ls.snippet_node, ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local l = require("luasnip.extras").lambda

ls.add_snippets("lua", {
	s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
})

ls.add_snippets("rust", {
	s(
		"modtest",
		fmt(
			[[
	 #[cfg(test)]
	 mod test {{
	 {}

		{}
	 }}
	]],
			{
				c(1, { t("	use super::*"), t("") }),
				i(0),
			}
		)
	),
})

local type_fields = function(info)
	local node = vim.treesitter.get_node()

	while node ~= nil do
		if node:type() == "variable_declarator" then
			break
		end
	end

	if not node then
		vim.notify("Couldn't find the function we're in")
	end

	vim.lsp.buf.type_definition()

	local query = assert(vim.treesitter.query.get("go", "return-snipper"), "No query")
	for _, capture in query:iter_captures(node, 0) do
		if handlers[capture:type()] then
			return handlers[capture:type()](capture, info)
		end
	end
	return i()
end

ls.add_snippets("typescriptreact", {
	s(
		"us",
		fmt(
			[[const [{}, set{setter}] = useState({});]],
			{ i(1), i(2), setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1) }
		)
	),
	s(
		"fc",
		fmt(
			[[
			    const {}: FC{} = ({}) => {{
					{}
				
					return {};
				}}
			]],
			{
				i(1),
				c(2, { sn(nil, fmt([[<{}>]], i(1))), t("") }),
				i(3), -- TODO: make this a function node using treesitter to autofill with the props?
				i(0),
				c(4, { sn(nil, fmt([[<div>{}</div>]], i(1))), sn(nil, fmt([[<>{}</>]], i(1))), i("") }),
			}
		)
	),
})
