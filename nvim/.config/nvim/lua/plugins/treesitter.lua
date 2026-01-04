return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "c",
      "c_sharp",
      "bash",
      "nu",
      "regex",
      "rust",
      "sql",
      "json",
    },
    auto_install = true, -- Automatically install missing parsers when entering buffer
    sync_install = false, -- Install parsers asynchronously
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<S-CR>",
        node_decremental = "<BS>",
      },
    },
    fold = {
      enable = true,
      disable = {},
    },
  },
  config = function(_, opts)
    -- Configure install settings
    require("nvim-treesitter.install").compilers = { "gcc", "cc", "clang" }
    require("nvim-treesitter.install").prefer_git = false

    -- Setup treesitter (using the new API)
    require("nvim-treesitter.configs").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql" },
      callback = function(args)
        vim.treesitter.start(args.buf, "sql")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "json" },
      callback = function(args)
        vim.treesitter.start(args.buf, "json")
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "bashrc", "sh" },
      callback = function(args)
        vim.treesitter.start(args.buf, "bash")
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "nu" },
      callback = function(args)
        vim.treesitter.start(args.buf, "nu")
      end,
    })

    -- In /home/otto/dotfiles/nvim/.config/nvim/lua/config/autocmds.lua
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "checkhealth",
      callback = function(args)
        vim.treesitter.stop(args.buf)
        vim.cmd("syntax on")
      end,
    })
  end,
}
