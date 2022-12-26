function excyber_color(color)
	color = color or "codedark"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end


vim.cmd [[colorscheme codedark]]
vim.cmd [[set t_Co=256]]