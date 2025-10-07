return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("neo-tree").setup({
				log_level = "info", -- or "error", "debug", etc.
				default_component_configs = {
					-- icon = {
					--   folder_closed = "",
					--   folder_open = "",
					--   folder_empty = "",
					--   folder_empty_open = "",
					--   default = "",  -- Default file icon
					-- },
					git_status = {
						symbols = {
							-- Custom git status icons
							added = "✚",
							modified = "",
							deleted = "",
							renamed = "➜",
							untracked = "",
							ignored = "◌",
							unstaged = "",
							staged = "",
							conflict = "",
						},
					},
					modified = {
						symbol = "", -- Modified file indicator
					},
					-- diagnostics = {
					-- 	symbols = {
					-- 		hint = "󰌶",
					-- 		info = "",
					-- 		warn = "",
					-- 		error = "",
					-- 	},
					-- 	highlights = {
					-- 		hint = "DiagnosticSignHint",
					-- 		info = "DiagnosticSignInfo",
					-- 		warn = "DiagnosticSignWarn",
					-- 		error = "DiagnosticSignError",
					-- 	},
					-- },
				},
			})
		end,
	},
}
