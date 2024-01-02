return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of assignment" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "Select outer part of conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner part of conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of loop" },

						["af"] = { query = "@call.outer", desc = "Select outer part of function call" },
						["if"] = { query = "@call.inner", desc = "Select inner part of function call" },

						["am"] = { query = "@function.outer", desc = "Select outer part of function definition" },
						["im"] = { query = "@function.inner", desc = "Select inner part of function definition" },

						["ac"] = { query = "@class.outer", desc = "Select outer part of class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of class" },
					},
				},
			},
		})
	end,
}
