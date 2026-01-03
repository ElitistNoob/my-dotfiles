return {
	"catppuccin/nvim",
	lazy = true,
	name = "catppuccin",
	-- priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			custom_highlights = function(colors)
				return {
					-- Normal = { bg = "#111111" },
					-- NormalNC = { bg = "#111111" },
					-- EndOfBuffer = { bg = "#111111" },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
