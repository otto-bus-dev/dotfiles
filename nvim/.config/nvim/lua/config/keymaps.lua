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
vim.api.nvim_set_keymap("n", "<Leader>y", '"+y', { noremap = true, silent = true })    -- Yank to clipboard
vim.api.nvim_set_keymap("n", "<Leader>p", '"+p', { noremap = true, silent = true })    -- Paste from clipboard
-- Split Navigation (left, below, above, right windows)
vim.api.nvim_set_keymap("n", "<Leader>h", "<C-w>h", { noremap = true, silent = true }) -- Left window
vim.api.nvim_set_keymap("n", "<Leader>j", "<C-w>j", { noremap = true, silent = true }) -- Below window
vim.api.nvim_set_keymap("n", "<Leader>k", "<C-w>k", { noremap = true, silent = true }) -- Above window
vim.api.nvim_set_keymap("n", "<Leader>l", "<C-w>l", { noremap = true, silent = true }) -- Right window
-- Resize Windows
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><", { noremap = true, silent = true })     -- Resize left
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>>", { noremap = true, silent = true })     -- Resize right
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>+", { noremap = true, silent = true })     -- Resize up
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>-", { noremap = true, silent = true })     -- Resize down
-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------
-- FILES
-------------------------------------------------------------------------------------------------------------
-- find files
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
-- find projects
vim.api.nvim_set_keymap("n", "<leader>fp", ":Telescope project<CR>", { noremap = true, silent = true })
-- live grep
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
-- Toggle NeoTree file explorer
vim.api.nvim_set_keymap("n", "<Leader>ft", ":Neotree toggle<CR>", { noremap = true, silent = true })
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
-- vim.api.nvim_set_keymap("n", "<Leader>q", ":copen<CR>", { noremap = true, silent = true })

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
-------------------------------------------------------------------------------------------------------------
--
-- copilot keybindings
-- Trigger Copilot suggestion manually
-- vim.api.nvim_set_keymap("i", "<C-Space>", "<Plug>(copilot-suggest)", { noremap = true, silent = true })
-- -- Accept Copilot suggestion
-- vim.api.nvim_set_keymap("i", "<C-Right>", "<Plug>(copilot-accept)", { noremap = true, silent = true })
-- -- Cycle to next suggestion
-- vim.api.nvim_set_keymap("i", "<C-Tab>", "<Plug>(copilot-next)", { noremap = true, silent = true })
--
-- -- Cycle to previous suggestion
-- kvim.api.nvim_set_keymap("i", "<C-S-Tab>", "<Plug>(copilot-previous)", { noremap = true, silent = true })
-- -- Dismiss Copilot suggestion
-- vim.api.nvim_set_keymap("i", "<C-Esc>", "<Plug>(copilot-dismiss)", { noremap = true, silent = true })

-------------------------------------------------------------------------------------------------------------
-- DADBOD
-------------------------------------------------------------------------------------------------------------
-- works at runtime, clean and safe
vim.api.nvim_set_keymap("n", "<Leader>pu", ":DBUIToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>pa", ":DBUIFindBuffer<CR>", { noremap = true, silent = true })
-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------
-- COPILOT
-------------------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<Leader>cw", ":CopilotChat<CR>", { noremap = true, silent = true })
-- Toggle Copilot Chat panel
vim.api.nvim_set_keymap("n", "<Leader>cf", ":CopilotChatToggle<CR>", { noremap = true, silent = true })
-- Clear Copilot Chat history
vim.api.nvim_set_keymap("n", "<Leader>ch", ":CopilotChatClear<CR>", { noremap = true, silent = true })
-------------------------------------------------------------------------------------------------------------

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
vim.api.nvim_set_keymap("n", "<Leader>L", ":Lazy<CR>", { noremap = true, silent = true })  -- Undo
vim.api.nvim_set_keymap("n", "<Leader>M", ":Mason<CR>", { noremap = true, silent = true }) -- Redo
-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------
-- WHICH-KEY DESCRIPTIONS
-- https://www.google.com
-------------------------------------------------------------------------------------------------------------
local wk = require("which-key")
-- Register which-key descriptions
wk.add({

  { "<Leader>w",    desc = "save" },
  { "<Leader>q",    desc = "quit" },
  { "<Leader>x",    desc = "save and quit" },
  { "<Leader>?",    desc = "help" },
  { "<Leader>n",    desc = ":set relativenumber!<CR>" },
  { "<Leader>N",    desc = ":set nu! relativenumber!<CR>" },
  { "<Leader>b",    group = "buffers" },
  { "<Leader>bn",   desc = "next" },
  { "<Leader>bp",   desc = "previous" },
  { "<Leader>br",   desc = "rename" },
  { "<Leader>ba",   desc = "action" },
  { "<Leader>y",    desc = "copy to clipboard" },
  { "<Leader>p",    desc = "paste from clipboard" },
  { "<Leader>h",    desc = "move to left window" },
  { "<Leader>j",    desc = "move to below window" },
  { "<Leader>k",    desc = "move to above window" },
  { "<Leader>l",    desc = "move to right window" },
  { "<C-h>",        desc = "resize left" },
  { "<C-l>",        desc = "resize right" },
  { "<C-k>",        desc = "resize up" },
  { "<C-j>",        desc = "resize down" },
  { "<leader>f",    group = "files" },
  { "<leader>ff",   desc = "find files" },
  { "<leader>fp",   desc = "find project" },
  { "<Leader>fg",   desc = "live grep" },
  { "<Leader>ft",   desc = "file tree" },
  { "g",            group = "lsp" },
  { "gd",           desc = "go to definition" },
  { "gr",           desc = "find references" },
  { "gD",           desc = "go to declaration" },
  { "gi",           desc = "go to implementation" },
  { "<F5>",         desc = "start/continue debugging" },
  { "<F9>",         desc = "toggle breakpoint" },
  { "<F10>",        desc = "step over" },
  { "<F11>",        desc = "step into" },
  { "<Leader>du",   desc = "toggle dap ui" },
  { "<leader><F2>", desc = "evaluate expression" },
  { "<Leader>c",    group = "copilot" },
  { "<Leader>cw",   desc = "window" },
  { "<Leader>cf",   desc = "floating" },
  { "<Leader>ch",   desc = "clear history" },
  { "<Leader>s",    desc = "source nvim config" },
  { "<Leader>L",    desc = "lazy" },
  { "<Leader>M",    desc = "mason" },
})
-------------------------------------------------------------------------------------------------------------
