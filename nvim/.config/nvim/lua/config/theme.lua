-- Clear default fillchars
vim.opt.fillchars = { eob = " " }
-- vim.cmd("colorscheme rose-pine")
require("notify").setup({
	background_colour = "#1f2335",
	text_colour = "#f1f1f0",
})

vim.opt.guicursor = "" -- Disables cursor shape changes
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number" -- or "number,line"

vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = "#ea9d34", -- foreground (text color)
	bold = true,
})
