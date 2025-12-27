return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "ellisonleao/dotenv.nvim",
    config = function()
      require("dotenv").setup({
        enable_on_load = true,
        verbose = false,
        file_name = ".env",
      })
    end,
  },
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- autocompletion source for lsp
      "ellisonleao/dotenv.nvim", -- load .env files
    },
    config = function()
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
                						autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 10000 })
              					augroup END
            				]])
        end
      end

      local signs = { Error = "", Warn = "", Hint = "⚑", Info = "" }

      vim.diagnostic.config({
        virtual_lines = {
          current_line = true,
          format = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = signs.Error,
              [vim.diagnostic.severity.WARN] = signs.Warn,
              [vim.diagnostic.severity.HINT] = signs.Hint,
              [vim.diagnostic.severity.INFO] = signs.Info,
            }
            local icon = icons[diagnostic.severity] or "●"
            local message = diagnostic.message
            local max_width = 80 -- Adjust to your preference
            -- Simple wrapping function
            local function wrap_text(text, width)
              local lines = {}
              local current_line = ""
              for word in text:gmatch("%S+") do
                if #current_line + #word + 1 > width then
                  table.insert(lines, current_line)
                  current_line = word
                else
                  current_line = current_line .. (current_line == "" and "" or " ") .. word
                end
              end
              if current_line ~= "" then
                table.insert(lines, current_line)
              end
              return lines
            end
            local wrapped = wrap_text(message, max_width)
            local result = string.format("%s %s", icon, wrapped[1])
            -- Add continuation lines with indentation
            for i = 2, #wrapped do
              result = result .. "\n  " .. wrapped[i]
            end
            return result
          end,
          source = "always",
          spacing = 2,
        },
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
          },
        },
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })

      -- Retrieve the environment variable
      local python_path = os.getenv("BLENDER_PYTHON_PATH")
      local blender_lib_path = os.getenv("BLENDER_PYTHON_LIB_PATH")
      local blender_bl_operators_path = os.getenv("BLENDER_PYTHON_BL_OPERATORS")
      -- notify the user if the environment variable is not set
      if not python_path or python_path == "" then
        vim.notify(
          "BLENDER_PYTHON_PATH environment variable shoud be set to enable PYTHON debugging for blender",
          vim.log.levels.ERROR
        )
      end

      -- Capabilities for autocompletion
      local capabilities = cmp_nvim_lsp.default_capabilities()
      vim.cmd("Dotenv")

      local final_python_path = os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python"
          or python_path
          or "/usr/bin/python3"

      -- MIGRATED TO vim.lsp.config()
      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = final_python_path,
            analysis = {
              extraPaths = {
                blender_lib_path,
                blender_bl_operators_path,
              },
              autosearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              disabled = { "non_snake_case" },
            },
          },
        },
      })
      vim.lsp.config("omnisharp", {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "OmniSharp" },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("*.sln")(fname)
              or util.root_pattern(".git")(fname)
              or util.root_pattern("Assets")(fname)
        end,
        settings = {
          omnisharp = {
            useModernNet = true,
            enableRoslynAnalyzers = true,
            msbuild = { loadProjectsOnDemand = false },
          },
        },
      })
      local helpers = require("null-ls.helpers")
      local sqlfluff_formatter = {
        method = null_ls.methods.FORMATTING,
        filetypes = { "sql" },
        generator = helpers.formatter_factory({
          command = "sh",
          args = {
            "-c",
            "echo 'Formatting.. .' >&2; sqlfluff fix --dialect snowflake - 2>/dev/null",
          },
          to_stdin = true,
        }),
      }
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier, -- JS, TS, JSON, etc.
          null_ls.builtins.formatting.stylua, -- Lua formatting
          null_ls.builtins.formatting.csharpier, -- C# Formatter
          null_ls.builtins.formatting.rustywind, -- Rust Formatter
          sqlfluff_formatter,
          null_ls.builtins.diagnostics.sqlfluff,
        },
        on_attach = on_attach,
      })
    end,
  },
  --
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
        ensure_installed = {
          "pyright",
          "lua_ls",
          "omnisharp",
        },
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
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.close(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "minuet" },
        }),
      })
    end,
  },
}
