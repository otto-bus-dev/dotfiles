-- Save and Quit
vim.api.nvim_set_keymap("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true }) -- Save
vim.api.nvim_set_keymap("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true }) -- Quit
vim.api.nvim_set_keymap("n", "<Leader>x", ":x<CR>", { noremap = true, silent = true }) -- Save and Quit

-- Toggle Line Numbers
vim.api.nvim_set_keymap("n", "<Leader>n", ":set relativenumber!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>N", ":set nu! relativenumber!<CR>", { noremap = true, silent = true })

-- Go to File (find file using fuzzy finder like `telescope`)
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fp", ":Telescope project<cr>", { noremap = true, silent = true })

-- Go to Line (find text using fuzzy search with `telescope`)
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

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
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w><", { noremap = true, silent = true })  -- Resize left
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>>", { noremap = true, silent = true }) -- Resize right
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>+", { noremap = true, silent = true })    -- Resize up
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>-", { noremap = true, silent = true })  -- Resize down

-- Go to Definition (with LSP)
vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Find References (with LSP)
vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })

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
vim.api.nvim_set_keymap("v", "<leader><F2>", '<cmd>lua require"dapui".eval()<CR>', { noremap = true, silent = true })
-- Quick Fix List (useful for showing errors from LSP or other tools)
vim.api.nvim_set_keymap("n", "<Leader>q", ":copen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>db", ':lua require"dapui".toggle()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", function()
  vim.loop.spawn("blender", {
    args = {
      "--python-expr",
      "import debugpy; debugpy.listen(('0.0.0.0', 5678)); debugpy.wait_for_client(); print('Blender is waiting for debugger to attach')",
    },
    detached = true,
  }, function() end)
end, { desc = "Start Blender with Debugpy" })

-- Open Neovim’s Help
vim.api.nvim_set_keymap("n", "<Leader>?", ":help<Space>", { noremap = true, silent = true })

-- Trigger Copilot suggestion manually
vim.api.nvim_set_keymap("i", "<C-Space>", "<Plug>(copilot-suggest)", { noremap = true, silent = true })
-- Accept Copilot suggestion
vim.api.nvim_set_keymap("i", "<C-Right>", "<Plug>(copilot-accept)", { noremap = true, silent = true })
-- Cycle to next suggestion
vim.api.nvim_set_keymap("i", "<C-Tab>", "<Plug>(copilot-next)", { noremap = true, silent = true })

-- Cycle to previous suggestion
vim.api.nvim_set_keymap("i", "<C-S-Tab>", "<Plug>(copilot-previous)", { noremap = true, silent = true })
-- Dismiss Copilot suggestion
vim.api.nvim_set_keymap("i", "<C-Esc>", "<Plug>(copilot-dismiss)", { noremap = true, silent = true })

-- Open Copilot Chat
vim.api.nvim_set_keymap("n", "<Leader>co", ":CopilotChat<CR>", { noremap = true, silent = true })
-- Toggle Copilot Chat panel
vim.api.nvim_set_keymap("n", "<Leader>cc", ":CopilotChatToggle<CR>", { noremap = true, silent = true })
-- Clear Copilot Chat history
vim.api.nvim_set_keymap("n", "<Leader>ch", ":CopilotChatClear<CR>", { noremap = true, silent = true })

-- Toggle NeoTree file explorer
vim.api.nvim_set_keymap("n", "<Leader>tt", ":Neotree toggle<CR>", { noremap = true, silent = true })
-- Focus on NeoTree window
vim.api.nvim_set_keymap("n", "<Leader>tf", ":Neotree focus<CR>", { noremap = true, silent = true })

-- Function to source Neovim configuration
function _G.source_config()
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("Configuration sourced!", vim.log.levels.INFO)
end

-- Keybinding to source Neovim configuration
vim.api.nvim_set_keymap("n", "<Leader>s", ":lua _G.source_config()<CR>", { noremap = true, silent = true })

-- Plugin management
vim.api.nvim_set_keymap("n", "<Leader>L", ":Lazy<CR>", { noremap = true, silent = true })  -- Undo
vim.api.nvim_set_keymap("n", "<Leader>M", ":Mason<CR>", { noremap = true, silent = true }) -- Redo

local wk = require("which-key")
-- Register which-key descriptions
wk.add({
  { "<Leader>?",  desc = "Open Help" },
  { "<Leader>L",  desc = "Open Lazy" },
  { "<Leader>M",  desc = "Open Mason" },
  { "<Leader>bn", desc = "Next Buffer" },
  { "<Leader>bp", desc = "Previous Buffer" },
  { "<Leader>c",  group = " Copilot" },
  { "<Leader>cc", desc = "Toggle Copilot Chat" },
  { "<Leader>ch", desc = "Clear Copilot Chat History" },
  { "<Leader>co", desc = "Open Copilot Chat" },
  { "<Leader>du", desc = "Toggle DAP UI" },
  { "<Leader>ff", desc = "Find File" },
  { "<Leader>g",  desc = "Live Grep" },
  { "<Leader>h",  desc = "Left Window" },
  { "<Leader>j",  desc = "Below Window" },
  { "<Leader>k",  desc = "Above Window" },
  { "<Leader>l",  desc = "Right Window" },
  { "<Leader>n",  desc = "Toggle Line Numbers" },
  { "<Leader>p",  desc = "Paste from Clipboard" },
  { "<Leader>q",  desc = "Quit" },
  { "<Leader>s",  desc = "Source Configuration" },
  { "<Leader>t",  group = " NeoTree" },
  { "<Leader>tf", desc = "Focus NeoTree" },
  { "<Leader>tt", desc = "Toggle NeoTree" },
  { "<Leader>u",  desc = "Undo" },
  { "<Leader>w",  desc = "Save" },
  { "<Leader>x",  desc = "Save and Quit" },
  { "<Leader>y",  desc = "Yank to Clipboard" },
})
