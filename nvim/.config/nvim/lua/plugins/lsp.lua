return {
	{
		"nvimtools/none-ls.nvim",
	},

	-- LSP Config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- autocompletion source for lsp
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local null_ls = require("null-ls")
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				-- LSP keymaps
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				-- Autoformat on save
				if client.server_capabilities.documentFormattingProvider then
					vim.cmd([[
            					augroup LspAutocommands
              						autocmd! * <buffer>
              						autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 1000 })
            					augroup END
          				]])
				end
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- or "E", or ""
					source = "always",
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Retrieve the environment variable

			local python_path = os.getenv("BLENDER_PYTHON_PATH")
			local blender_lib_path = os.getenv("BLENDER_PYTHON_LIB_PATH")
			local blender_bl_operators_path = os.getenv("BLENDER_PYTHON_BL_OPERATORS")

			local python_version = vim.fn.systemlist("ls $BLENDER_PYTHON_PATH/bin | grep python")[1]

			-- notify the user if the environment variable is not set
			if not python_path or python_path == "" then
				vim.notify(
					"BLENDER_PYTHON_PATH environment variable shoud be set to enable PYTHON debugging for blender",
					vim.log.levels.ERROR
				)
			end
			-- Capabilities for autocompletion
			local capabilities = cmp_nvim_lsp.default_capabilities()
			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							extraPaths = {
								blender_lib_path,
								blender_bl_operators_path,
							}, -- Replace with the actual path to Blender libraries
							autosearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false, -- Prevent prompt for third-party libraries
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			-- Setup OmniSharp for Unity (without requiring .sln file)
			lspconfig.omnisharp.setup({
				cmd = { "omnisharp" },
				root_dir = function(fname)
					return lspconfig.util.root_pattern("*.sln")(fname) -- Try .sln first
						or lspconfig.util.root_pattern(".git")(fname) -- Otherwise, use .git
						or lspconfig.util.root_pattern("Assets")(fname) -- Last fallback for Unity
				end,
				settings = {
					omnisharp = {
						useModernNet = true,
						enableRoslynAnalyzers = true,
						msbuild = {
							loadProjectsOnDemand = false,
						},
					},
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Setup null-ls for extra formatting and linting
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier, -- JS, TS, JSON, etc.
					null_ls.builtins.formatting.stylua, -- Lua formatting
					null_ls.builtins.formatting.csharpier, -- C# Formatter
					null_ls.builtins.formatting.rustfmt, -- Rust Formatter
					null_ls.builtins.diagnostics.rustfmt, -- Rust Linter
				},
				border = "rounded", -- Add this line to set the border to rounded
				on_attach = on_attach,
			})

			-- Set rounded border for hover window
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})
		end,
	},

	-- Mason (LSP Installer)
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},

	-- Mason LSP Config (Ensures LSPs are installed)
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "lua_ls", "omnisharp" },
				automatic_installation = true,
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
