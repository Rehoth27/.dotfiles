return {

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = false,
				terminal_colors = true,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Open Oil file explorer",
			},
		},

		config = function()
			require("oil").setup({
				default_file_explorer = true,

				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					cursorline = true,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "oil",
				callback = function()
					vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f2335" })
					vim.api.nvim_set_hl(0, "Directory", { fg = "#7dcfff", bold = true })
				end,
			})
		end,
	},
}
