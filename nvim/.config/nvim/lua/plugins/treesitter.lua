return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- Automatically update parsers after installation
	event = { "BufReadPost", "BufNewFile" }, -- Load Treesitter when opening a file
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- Adds advanced text objects
	},
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"c", --, "cpp", "python", "rust",
			"c_sharp", --, "json", "yaml", "bash"
		}, -- List of languages to install parsers for
		highlight = {
			enable = true, -- Enable Treesitter-based syntax highlighting
		},
		indent = {
			enable = true, -- Enable Treesitter-based indentation
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>", -- Start selection
				node_incremental = "<CR>", -- Expand selection by node
				scope_incremental = "<S-CR>", -- Expand selection by scope
				node_decremental = "<BS>", -- Shrink selection by node
			},
		},
		-- Optional: Enable folding with Treesitter (If you want code folding)
		fold = {
			enable = true,
			disable = {}, -- Optional: Disable folding for specific languages
		},
	},
	config = function(_, opts)
		-- Set up Treesitter with the provided options
		require("nvim-treesitter.configs").setup(opts)
	end,
}
