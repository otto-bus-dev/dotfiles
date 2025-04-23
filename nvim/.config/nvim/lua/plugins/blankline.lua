return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      exclude = {
        filetypes = { "dashboard", "NvimTree", "packer", "alpha", "startify" }, -- Add your dashboard file type here
        buftypes = { "terminal", "nofile" },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },
}
