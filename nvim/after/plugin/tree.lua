
vim.g.nvim_tree_indent_markers = 1

vim.cmd("nnoremap <leader>o :NvimTreeOpen<CR>")
vim.cmd("nnoremap <leader>e :NvimTreeToggle<CR>")
vim.cmd("nnoremap <leader>r :NvimTreeRefresh<CR>")
vim.cmd("nnoremap <leader>n :NvimTreeFindFile<CR>")
vim.cmd("nnoremap <leader>f :NvimTreeFocus<CR>")


-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.g.nvim_tree_highlight_opened_files = 1

--vim.g.nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } 

require('nvim-tree').setup {
	enable = true,
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = true,
	ignore_ft_on_setup = {'dashboard'},
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
	system_open = {
			-- the command to run this, leaving nil should work in most cases
			cmd = nil,
			-- the command arguments as a list
			args = {}
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = 'left',
		auto_resize = false,
		mappings = {
			custom_only = false,
		}
	},
	actions = {
		open_file = {
				resize_window = true
		}
	}
}
