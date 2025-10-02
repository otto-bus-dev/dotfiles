return {
  { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                    -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim",        branch = "master" }, -- for curl, log and async functions
      { "nvim-telescope/telescope.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      window = {
        layout = "float",
        relative = "editor",
        width = 0.5,
        height = 0.5,
        col = nil,
        row = nil,
        border = "rounded",
      },
      question_header = "Otto", -- Change to your preferred user name
      answer_header = "Yoda", -- Change to your preferred bot name
    },
    config = function(_, opts)
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
}
