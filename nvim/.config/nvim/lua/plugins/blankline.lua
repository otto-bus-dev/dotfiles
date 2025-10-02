return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = { "dashboard", "NvimTree", "packer", "alpha", "startify" },
				buftypes = { "terminal", "nofile" },
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
}
