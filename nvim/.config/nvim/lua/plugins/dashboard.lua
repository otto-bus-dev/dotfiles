return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config

				theme = "hyper",
				config = {
					project = {
						enable = true,
						limit = 8,
						icon = "󰯉 ",
						label = "Otto's Projects",
						action = "Telescope project project",
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
