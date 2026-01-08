-- Clear default fillchars
vim.opt.fillchars = { eob = " " }
-- vim.cmd("colorscheme rose-pine")
require("notify").setup({
	background_colour = "#1f2335",
	text_colour = "#f1f1f0",
})
-- vim.api.nvim_set_hl(0, "CursorNormal", { bg = "#d18983" }) -- Lighter rose
vim.api.nvim_set_hl(0, "CursorNormal", { bg = "#553f4e" }) -- Lighter rose
vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#378498" }) -- Lighter blue
vim.api.nvim_set_hl(0, "CursorVisual", { bg = "#63577d" }) -- Lighter purple

vim.opt.guicursor = {
	"n:block-CursorNormal",
	"i-ci:ver25-CursorInsert",
	"v-ve:block-CursorVisual",
	"r-cr:hor20-CursorNormal",
}

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number" -- or "number,line"

vim.opt.scrolloff = 5

vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = "#ea9d34", -- foreground (text color)
	bold = true,
})
