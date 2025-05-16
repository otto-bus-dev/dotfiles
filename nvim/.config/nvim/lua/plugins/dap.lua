return {
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			-- Retrieve the environment variable
			local python_path = os.getenv("BLENDER_PYTHON_PATH")
			local python_version = vim.fn.systemlist("ls $BLENDER_PYTHON_PATH/bin | grep python")[1]
			-- notify the user if the environment variable is not set
			if not python_path or python_path == "" then
				vim.notify(
					"BLENDER_PYTHON_PATH environment variable shoud be set to enable PYTHON debugging for blender",
					vim.log.levels.ERROR
				)
			end
			require("dap-python").setup("python3") -- .. "/bin/" .. python_version)
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			if not dap then
				print("Error: nvim-dap not found")
				return
			end
			dap.adapters.unity = {
				type = "executable",
				command = "mono",
				args = {
					vim.fn.stdpath("config") .. "/dependencies/dap/vscode-unity-debug/bin/UnityDebug.exe",
					"--unity",
				},
			}
			--
			dap.configurations.cs = {
				{
					type = "unity",
					name = "Unity Editor",
					request = "attach",
				},
			}
			dap.adapters.blender = {
				type = "server",
				host = "127.0.0.1",
				port = 5678,
			}

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb", -- Update this path
					args = { "--port", "${port}" },
				},
			}
			dap.configurations.rust = {
				{
					name = "Debug",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- dap.configurations.python = {
			--   {
			--     type = 'blender',
			--     request = 'attach',
			--     repl_lang = 'python',
			--     filetype = 'python',
			--     mode = 'remote',
			--     name = 'Attach to Blender',
			--     -- host = 'localhost',
			--     -- port = 5678,
			--     justMyCode = false,
			--     console = 'internalTerminal',
			--   }
			-- }
			-- Define highlight groups with the desired colors
			vim.cmd([[
        highlight DapBreakpoint ctermfg=grey guifg='#908caa'
        highlight DapStopped ctermfg=red guifg='#eb6f92'
        highlight DapUIControlIconDisconnect guifg=#908caa guibg=NONE
        highlight DapUiPauseIcon guifg=#908caa guibg=NONE
        highlight DapUiPlayIcon guifg=#9ccfd8 guibg=NONE
        highlight DapUiRunLastIcon guifg=#908caa guibg=NONE
        highlight DapUiStepBackIcon guifg=#908caa guibg=NONE
        highlight DapUiStepOutIcon guifg=#908caa guibg=NONE
        highlight DapUiStepOverIcon guifg=#908caa guibg=NONE
        highlight DapUiStepIntoIcon guifg=#908caa guibg=NONE
        highlight DapUiTerminateIcon guifg=#eb6f92 guibg=NONE
      ]])

			vim.cmd([[
  "hi default link DapUINormal Normal
  "hi default link DapUIVariable Normal
  "hi default DapUIScope guifg=#00F1F5
  "hi default DapUIType guifg=#D484FF
  "hi default link DapUIValue Normal
  "hi default DapUIModifiedValue guifg=#00F1F5 gui=bold
  "hi default DapUIDecoration guifg=#00F1F5
  "hi default DapUIThread guifg=#A9FF68
  "hi default DapUIStoppedThread guifg=#00f1f5
  "hi default link DapUIFrameName Normal
  "hi default DapUISource guifg=#D484FF
  "hi default DapUILineNumber guifg=#00f1f5
  "hi default link DapUIFloatNormal NormalFloat
  "hi default DapUIFloatBorder guifg=#00F1F5
  "hi default DapUIWatchesEmpty guifg=#F70067
  "hi default DapUIWatchesValue guifg=#A9FF68
  "hi default DapUIWatchesError guifg=#F70067
  "hi default DapUIBreakpointsPath guifg=#00F1F5
  "hi default DapUIBreakpointsInfo guifg=#A9FF68
  "hi default DapUIBreakpointsCurrentLine guifg=#A9FF68 gui=bold
  "hi default link DapUIBreakpointsLine DapUILineNumber
  "hi default DapUIBreakpointsDisabledLine guifg=#424242
  "hi default link DapUICurrentFrameName DapUIBreakpointsCurrentLine
  hi default DapUIStepOver guifg=#908caa
  hi default DapUIStepInto guifg=#908caa
  hi default DapUIStepBack guifg=#908caa
  hi default DapUIStepOut guifg=#908caa
  hi default DapUIStop guifg=#eb6f92 guibg=NONE
  hi default DapUIPlayPause guifg=#9ccfd8 guibg=#44415a ctermbg=NONE
  hi default DapUIRestart guifg=#A9FF68 guibg=NONE ctermbg=NONE
  hi default WinBar guifg=#44415a guibg=#44415a
  ]])
			-- Ensure nvim-dap-ui is configured
			local dapui = require("dapui")
			if dapui then
				dapui.setup({
					controls = {
						element = "repl",
						enabled = true,
						icons = {
							disconnect = "",
							pause = "",
							play = "",
							step_back = "",
							step_into = "",
							step_out = "",
							step_over = "",
							terminate = "",
						},
						highlight = {
							pause = "DapUiPauseIcon",
							play = "DapUiPlayIcon",
							step_into = "DapUiStepIntoIcon",
							step_over = "DapUiStepOverIcon",
							step_out = "DapUiStepOutIcon",
							step_back = "DapUiStepBackIcon",
							run_last = "DapUiRunLastIcon",
							terminate = "DapUiTerminateIcon",
						},
					},
					icons = { expanded = "▾", collapsed = "▸" },
				})

				vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
				vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })

				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			else
				print("Error: nvim-dap-ui not found")
			end
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = { "mono-debug", "debugpy" },
			automatic_installation = true,
		},
	},
}
