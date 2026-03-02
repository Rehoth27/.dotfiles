return {

	-- TOKYO NIGHT THEME
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

	-- OIL FILE EXPLORER
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
				columns = { "icon" },

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

				view_options = {
					show_hidden = true,
				},
			})

			local function define_hl_groups()
				vim.api.nvim_set_hl(0, "OilDir", { fg = "#7dcfff", bold = true })
				vim.api.nvim_set_hl(0, "OilDirIcon", { fg = "#7dcfff" })
				vim.api.nvim_set_hl(0, "OilAudio", { fg = "#ff79c6" })
				vim.api.nvim_set_hl(0, "OilImage", { fg = "#73daca" })
				vim.api.nvim_set_hl(0, "OilDoc", { fg = "#e0af68" })
				vim.api.nvim_set_hl(0, "OilCode", { fg = "#7aa2f7" })
				vim.api.nvim_set_hl(0, "OilScript", { fg = "#9ece6a" })
				vim.api.nvim_set_hl(0, "OilConfig", { fg = "#e0af68" })
				vim.api.nvim_set_hl(0, "OilArchive", { fg = "#ff9e64" })
				vim.api.nvim_set_hl(0, "OilMarkdown", { fg = "#7aa2f7" })
				vim.api.nvim_set_hl(0, "OilFile", { fg = "#c0caf5" })
				vim.api.nvim_set_hl(0, "OilHidden", { fg = "#565f89", italic = true })
				vim.api.nvim_set_hl(0, "OilLink", { fg = "#bb9af7", italic = true })
				vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1b2e" })
				vim.api.nvim_set_hl(0, "Directory", { fg = "#7dcfff", bold = true })
			end

			local function apply_oil_matches()
				vim.fn.clearmatches()

				-- Each pattern matches the ENTIRE line so the whole filename is colored.
				-- Priority order matters: higher number wins. Default is 10.
				-- We set specific types at 12 so they beat the generic fallback at 10.

				-- Generic file fallback (lowest priority) — soft white
				vim.fn.matchadd("OilFile", [[.*]], 10)

				-- Directories: lines ending with /
				vim.fn.matchadd("OilDir", [[.*/$]], 12)

				-- Hidden dot-files/dirs: lines whose filename starts with .
				-- (after any leading whitespace/icon characters)
				vim.fn.matchadd("OilHidden", [[\v^\s*\S*\s+\..*]], 13)

				-- Symlinks: lines containing ->
				vim.fn.matchadd("OilLink", [[.*->.*]], 13)

				-- Audio
				vim.fn.matchadd("OilAudio", [[\v.*\.(mp3|flac|wav|ogg|aac|m4a|opus|wma|aiff)$]], 14)

				-- Images
				vim.fn.matchadd("OilImage", [[\v.*\.(png|jpg|jpeg|gif|webp|svg|ico|bmp|tiff|raw|heic)$]], 14)

				-- Documents / PDF
				vim.fn.matchadd("OilDoc", [[\v.*\.(pdf|docx?|xlsx?|pptx?|odt|ods|odp|epub)$]], 14)

				-- Archives
				vim.fn.matchadd("OilArchive", [[\v.*\.(zip|tar|gz|bz2|xz|7z|rar|zst)$]], 14)

				-- Scripts
				vim.fn.matchadd("OilScript", [[\v.*\.(sh|bash|zsh|fish|py|lua|rb|pl|php)$]], 14)

				-- Markdown / text
				vim.fn.matchadd("OilMarkdown", [[\v.*\.(md|markdown|txt|rst|org)$]], 14)

				-- Config / data
				vim.fn.matchadd("OilConfig", [[\v.*\.(json|yaml|yml|toml|ini|cfg|conf|env|xml)$]], 14)

				-- Code
				vim.fn.matchadd(
					"OilCode",
					[[\v.*\.(c|cpp|h|hpp|cs|java|go|rs|ts|tsx|js|jsx|vue|css|scss|html|htm|sql)$]],
					14
				)
			end

			define_hl_groups()

			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = define_hl_groups,
			})

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = "oil://*",
				callback = function()
					vim.defer_fn(apply_oil_matches, 10)
				end,
			})
		end,
	},
}
