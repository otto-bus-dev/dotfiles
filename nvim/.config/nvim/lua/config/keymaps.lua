-- Save and Quit
-------------------------------------------------------------------------------------------------------------
-- GENERAL KEYBINDINGS
-------------------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true }) -- Save
vim.api.nvim_set_keymap("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true }) -- Quit
vim.api.nvim_set_keymap("n", "<Leader>x", ":x<CR>", { noremap = true, silent = true }) -- Save and Quit
-- Open Neovim’s Help
vim.api.nvim_set_keymap("n", "<Leader>?", ":help<Space>", { noremap = true, silent = true })
-- Toggle Line Numbers
vim.api.nvim_set_keymap("n", "<Leader>n", ":set relativenumber!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>N", ":set nu! relativenumber!<CR>", { noremap = true, silent = true })
-- Buffer Navigation (next/previous buffer)
vim.api.nvim_set_keymap("n", "<Leader>bn", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>bp", ":bprev<CR>", { noremap = true, silent = true })
-- Yank and Paste to/from Clipboard
vim.api.nvim_set_keymap("n", "<Leader>y", '"+y', { noremap = true, silent = true }) -- Yank to clipboard
vim.api.nvim_set_keymap("n", "<Leader>p", '"+p', { noremap = true, silent = true }) -- Paste from clipboard
-- Split Navigation (left, below, above, right windows)
vim.api.nvim_set_keymap("n", "<Leader>h", "<C-w>h", { noremap = true, silent = true }) -- Left window
vim.api.nvim_set_keymap("n", "<Leader>j", "<C-w>j", { noremap = true, silent = true }) -- Below window
vim.api.nvim_set_keymap("n", "<Leader>k", "<C-w>k", { noremap = true, silent = true }) -- Above window
vim.api.nvim_set_keymap("n", "<Leader>l", "<C-w>l", { noremap = true, silent = true }) -- Right window
-- Resize Windows
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><", { noremap = true, silent = true }) -- Resize left
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>>", { noremap = true, silent = true }) -- Resize right
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>+", { noremap = true, silent = true }) -- Resize up
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>-", { noremap = true, silent = true }) -- Resize down
-------------------------------------------------------------------------------------------------------------

-- save nvim session (work with tmux resurect)
vim.api.nvim_set_keymap("n", "<Leader>t", ":Obsession<CR>", { noremap = true, silent = true })
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-- FILES
-------------------------------------------------------------------------------------------------------------
-- find files
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { noremap = true, silent = true })
-- find projects
vim.api.nvim_set_keymap("n", "<leader>fp", ":Telescope project<CR>", { noremap = true, silent = true })
-- live grep
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
-- Toggle NeoTree file explorer
vim.api.nvim_set_keymap("n", "<Leader>ft", ":Neotree toggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<Leader>ha",
	':lua require("harpoon.mark").add_file()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>hu",
	':lua require("harpoon.ui").toggle_quick_menu()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>hd",
	':lua require("harpoon.ui").toggle_quick_menu()<CR>',
	{ noremap = true, silent = true }
)

-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------
-- Debugging Keybindings (using nvim-dap and dap-ui)
-------------------------------------------------------------------------------------------------------------
-- Start Debugging (with nvim-dap)
vim.api.nvim_set_keymap("n", "<F9>", ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
-- Start Debugging (with nvim-dap)
vim.api.nvim_set_keymap("n", "<F5>", ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
-- Step Over (with nvim-dap)
vim.api.nvim_set_keymap("n", "<F10>", ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
-- Step Over (with nvim-dap)
vim.api.nvim_set_keymap("n", "<F11>", ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
-- Toggle DAP UI (for debugging interface)
vim.api.nvim_set_keymap("n", "<Leader>du", ':lua require"dapui".toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><F2>", '<cmd>lua require"dapui".eval()<CR>', { noremap = true, silent = true })

-- -- Quick Fix List (useful for showing errors from LSP or other tools)
vim.api.nvim_set_keymap("n", "<Leader>q", ":copen<CR>", { noremap = true, silent = true })

--
-- vim.keymap.set("n", "<leader>bd", function()
-- 	vim.loop.spawn("blender", {
-- 		args = {
-- 			"--python-expr",
-- 			"import debugpy; debugpy.listen(('0.0.0.0', 5678)); debugpy.wait_for_client(); print('Blender is waiting for debugger to attach')",
-- 		},
-- 		detached = true,
-- 	}, function() end)
-- end, { desc = "Start Blender with Debugpy" })
--
---------------------------------------------------------------------------------------------------------------
-- DADBOD
-------------------------------------------------------------------------------------------------------------
-- works at runtime, clean and safe
vim.api.nvim_set_keymap("n", "<Leader>pu", ":DBUIToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>pa", ":DBUIFindBuffer<CR>", { noremap = true, silent = true })
-------------------------------------------------------------------------------------------------------------
-- CONFIG
-------------------------------------------------------------------------------------------------------------
-- Function to source Neovim configuration
function _G.source_config()
	vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
	vim.notify("Configuration sourced!", vim.log.levels.INFO)
end

-- reload configuration
vim.api.nvim_set_keymap("n", "<Leader>s", ":lua _G.source_config()<CR>", { noremap = true, silent = true })
-- Plugin management
vim.api.nvim_set_keymap("n", "<Leader>L", ":Lazy<CR>", { noremap = true, silent = true }) -- Undo
vim.api.nvim_set_keymap("n", "<Leader>M", ":Mason<CR>", { noremap = true, silent = true }) -- Redo
-------------------------------------------------------------------------------------------------------------
