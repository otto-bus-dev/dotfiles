return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
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
