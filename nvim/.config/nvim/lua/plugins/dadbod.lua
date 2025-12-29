-- Place this in your lazy plugins folder (e.g. ~/.config/nvim/lua/plugins/ or ~/.config/nvim/lua/custom/plugins/)
-- Lazy will pick this up if your LazyVim setup loads that folder.
return {
	{
		"tpope/vim-dadbod",
		cmd = { "DB", "DBUI" }, -- lazy-load on these commands
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" }, -- lazy-load UI commands
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_winwidth = 35
			vim.g.dbs = {}
		end,
		config = function()
			-- small UI tweak (optional)
			-- use nerd fonts for icons if you have them
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_use_postgres_views = 1
			-- optionally set where DBUI stores saved queries (adjust if desired)
			-- vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dbui"
			vim.g.db_ui_use_nvim_notify = 1
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = { "tpope/vim-dadbod" },
		event = "InsertEnter", -- load when inserting text (for completion helpers)
	},
}
