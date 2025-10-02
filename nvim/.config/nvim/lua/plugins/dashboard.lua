return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config

				theme = "hyper",
				config = {
					header = {
						" ██████╗ ████████╗████████╗ ██████╗  ██╗ ███████╗    ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗███████╗",
						"██╔═══██╗╚══██╔══╝╚══██╔══╝██╔═══██╗ ╚═╝ ██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝██╔════╝",
						"██║   ██║   ██║      ██║   ██║   ██║     ███████╗    ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║   ███████╗",
						"██║   ██║   ██║      ██║   ██║   ██║     ╚════██║    ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║   ╚════██║",
						"╚██████╔╝   ██║      ██║   ╚██████╔╝     ███████║    ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║   ███████║",
						" ╚═════╝    ╚═╝      ╚═╝    ╚═════╝      ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   ╚══════╝",
					},
					shortcut = {
						{ desc = "󰊳 update", group = "@property", action = "Lazy update", key = "u" },
						{
							desc = "󰯉  projects",
							group = "Keyword",
							action = "Telescope project",
							key = "p",
						},
						{
							desc = " files",
							group = "Keyword",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " theme",
							group = "@attribute",
							action = "Telescope colorscheme",
							key = "t",
						},
						{
							desc = " dotfiles",
							group = "Number",
							action = "Telescope find_files find_command=rg,--ignore,--hidden,--files cwd=~/dotfiles ",
							key = "d",
						},
					},
					project = {
						enable = true,
						limit = 8,
						icon = "󰯉 ",
						label = "otto's projects",
						group = "Keyword",
						action = "Telescope find_files ind_command=rg,--ignore,--hidden,--files cwd=",
					},
					footer = { "otto  neovim" },
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
