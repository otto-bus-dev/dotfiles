return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Refresh lualine when macro recording starts/stops and during recording
			local recording = false

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "rose-pine",
					globalstatus = true,
					-- section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					-- component_separators = { left = "︱", right = "︱" },
					disabled_filetypes = {
						statusline = { "TelescopePrompt", "dashboard", "neo-tree" },
					},
					ignore_focus = { "neo-tree" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename", "diagnostics" },
					lualine_x = {

						{
							function()
								if _G.macro_recording and _G.macro_recording.register ~= "" then
									local keys = _G.macro_recording.keys
									-- Limit display length
									if #keys > 20 then
										keys = "..." .. keys:sub(-20)
									end
									return "󰑋 @" .. _G.macro_recording.register .. " " .. keys
								end
								return ""
							end,
							color = { fg = "#eb6f92", gui = "bold" },
						},
						{
							function()
								return vim.fn.ObsessionStatus("", "")
							end,
							color = { fg = "#9ccfd8" }, -- rose-pine foam color
						},
						"encoding",
						"fileformat",
						"filetype",
						"lsp_status",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				extensions = { "fugitive", "neo-tree" },
			})
		end,
	},
}
