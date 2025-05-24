return {
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					vim.notify = require("notify")
				end,
			},
		},
		opts = {},
	},
}
