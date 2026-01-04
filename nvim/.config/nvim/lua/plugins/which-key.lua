return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register all keymaps with descriptions
      wk.add({
        -------------------------------------------------------------------------------------------------------------
        -- GENERAL OPERATIONS
        -------------------------------------------------------------------------------------------------------------
        { "<leader>n",   desc = "Toggle relative numbers" },
        { "<leader>N",   desc = "Toggle line numbers" },

        -------------------------------------------------------------------------------------------------------------
        -- BUFFER MANAGEMENT
        -------------------------------------------------------------------------------------------------------------
        { "<leader>b",   group = "Buffers" },
        { "<leader>bn",  desc = "Next buffer" },
        { "<leader>bp",  desc = "Previous buffer" },
        { "<leader>bd",  desc = "Delete buffer" },
        { "<leader>bD",  desc = "Force delete buffer" },

        -------------------------------------------------------------------------------------------------------------
        -- WINDOW MANAGEMENT
        -------------------------------------------------------------------------------------------------------------
        { "<leader>h",   desc = "Move to left window" },
        { "<leader>j",   desc = "Move to below window" },
        { "<leader>k",   desc = "Move to above window" },
        { "<leader>l",   desc = "Move to right window" },
        { "<C-h>",       desc = "Decrease window width" },
        { "<C-l>",       desc = "Increase window width" },
        { "<C-k>",       desc = "Increase window height" },
        { "<C-j>",       desc = "Decrease window height" },

        { "<leader>w",   group = "Windows" },
        { "<leader>wv",  desc = "Vertical split" },
        { "<leader>ws",  desc = "Horizontal split" },
        { "<leader>wc",  desc = "Close window" },
        { "<leader>wo",  desc = "Close other windows" },

        -------------------------------------------------------------------------------------------------------------
        -- FILE OPERATIONS (Telescope & NeoTree)
        -------------------------------------------------------------------------------------------------------------
        { "<leader>f",   group = "Files" },
        { "<leader>ff",  desc = "Find files (Telescope)" },
        { "<leader>fg",  desc = "Live grep (Telescope)" },
        { "<leader>fp",  desc = "Find project (Telescope)" },
        { "<leader>ft",  desc = "Toggle file tree (NeoTree)" },

        -------------------------------------------------------------------------------------------------------------
        -- HARPOON (Quick File Navigation)
        -------------------------------------------------------------------------------------------------------------
        { "<leader>fh",  group = "Harpoon" },
        { "<leader>fha", desc = "Add file to Harpoon" },
        { "<leader>fhu", desc = "Toggle Harpoon menu" },
        { "<leader>fhd", desc = "Remove from Harpoon" },

        -------------------------------------------------------------------------------------------------------------
        -- LSP (Language Server Protocol)
        -------------------------------------------------------------------------------------------------------------
        { "g",           group = "LSP" },
        { "gd",          desc = "Go to definition" },
        { "gD",          desc = "Go to declaration" },
        { "gi",          desc = "Go to implementation" },
        { "gr",          desc = "Find references" },
        { "K",           desc = "Hover documentation" },

        { "<leader>r",   group = "Refactor" },
        { "<leader>rn",  desc = "Rename symbol" },

        { "<leader>c",   group = "Code" },
        { "<leader>ca",  desc = "Code actions" },
        { "<leader>cr",  desc = "Reload config" },
        { "<leader>cl",  desc = "Open Lazy" },
        { "<leader>cm",  desc = "Open Mason" },
        { "<leader>ch",  desc = "Check health" },
        { "<leader>co",  desc = "Open quickfix" },
        { "<leader>cc",  desc = "Close quickfix" },
        { "<leader>cn",  desc = "Next quickfix item" },
        { "<leader>cp",  desc = "Previous quickfix item" },

        -------------------------------------------------------------------------------------------------------------
        -- GIT (LazyGit)
        -------------------------------------------------------------------------------------------------------------
        { "<leader>G",   desc = "Open LazyGit" },

        -------------------------------------------------------------------------------------------------------------
        -- DATABASE (Dadbod)
        -------------------------------------------------------------------------------------------------------------
        { "<leader>d",   group = "Database" },
        { "<leader>du",  desc = "Toggle DB UI" },
        { "<leader>df",  desc = "Find DB buffer" },

        -------------------------------------------------------------------------------------------------------------
        -- SESSION MANAGEMENT (Vim Obsession)
        -------------------------------------------------------------------------------------------------------------
        { "<leader>t",   group = "Session" },
        { "<leader>ts",  desc = "Save session (Obsession)" },
        { "<leader>tS",  desc = "Stop session tracking" },

        -------------------------------------------------------------------------------------------------------------
        -- DEBUGGING (DAP - commented out since dap.lua is deleted, but keeping for reference)
        -------------------------------------------------------------------------------------------------------------
        -- { "<F5>", desc = "Start/Continue debugging" },
        -- { "<F9>", desc = "Toggle breakpoint" },
        -- { "<F10>", desc = "Step over" },
        -- { "<F11>", desc = "Step into" },
        -- { "<leader>d", group = "Debug" },
        -- { "<leader>du", desc = "Toggle DAP UI" },
        -- { "<leader><F2>", desc = "Evaluate expression" },

        -------------------------------------------------------------------------------------------------------------
        -- PLUGIN MANAGEMENT
        -------------------------------------------------------------------------------------------------------------
        { "<leader>L",   desc = "Open Lazy" },
        { "<leader>M",   desc = "Open Mason" },
        { "<leader>s",   desc = "Reload config" },

        -------------------------------------------------------------------------------------------------------------
        -- COMPLETION (nvim-cmp) - Insert mode
        -------------------------------------------------------------------------------------------------------------
        -- Note: These are handled by nvim-cmp and shown in completion menu
        -- <C-n> - Select next item
        -- <C-p> - Select previous item
        -- <C-Space> - Trigger completion
        -- <CR> - Confirm selection
        -- <C-e> - Close completion

        -------------------------------------------------------------------------------------------------------------
        -- TREESITTER (Incremental Selection)
        -------------------------------------------------------------------------------------------------------------
        -- Note: These are context-specific
        -- <CR> - Init/expand selection
        -- <S-CR> - Scope incremental
        -- <BS> - Node decremental

        -------------------------------------------------------------------------------------------------------------
        -- TELESCOPE PROJECT MAPPINGS (Inside Telescope Project Picker)
        -------------------------------------------------------------------------------------------------------------
        -- Normal mode (n):
        --   d - Delete project
        --   r - Rename project
        --   c - Add project
        --   C - Add project (cwd)
        --   f - Find project files
        --   b - Browse project files
        --   s - Search in project files
        --   R - Recent project files
        --   w - Change working directory
        --   o - Next cd scope
        --
        -- Insert mode (i):
        --   <c-d> - Delete project
        --   <c-v> - Rename project
        --   <c-a> - Add project
        --   <c-A> - Add project (cwd)
        --   <c-f> - Find project files
        --   <c-b> - Browse project files
        --   <c-s> - Search in project files
        --   <c-r> - Recent project files
        --   <c-l> - Change working directory
        --   <c-o> - Next cd scope

        -------------------------------------------------------------------------------------------------------------
        -- TEXT OPERATIONS
        -------------------------------------------------------------------------------------------------------------
        { "J",           desc = "Move line down",            mode = "v" },
        { "K",           desc = "Move line up",              mode = "v" },
        { "<C-d>",       desc = "Scroll down (centered)" },
        { "<C-u>",       desc = "Scroll up (centered)" },
        { "n",           desc = "Next search (centered)" },
        { "N",           desc = "Previous search (centered)" },
        { "<",           desc = "Indent left",               mode = "v" },
        { ">",           desc = "Indent right",              mode = "v" },
        { "<Esc>",       desc = "Clear search highlight" },
      })
    end,
  },
}
