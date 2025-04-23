return {
	{ "github/copilot.vim" },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			window = {
				layout = "float",
				relative = "editor",
				width = 0.5,
				height = 0.5,
				col = nil,
				row = nil,
				border = "rounded",
			},
			question_header = "Otto", -- Change to your preferred user name
			answer_header = "Yoda", -- Change to your preferred bot name
		},
	},
}
