
	-- This file can be loaded by calling `lua require('plugins')` from your init.vim

	-- Only required if you have packer configured as `opt`
	vim.cmd [[packadd packer.nvim]]

	return require('packer').startup(function(use)
		-- Packer can manage itself
		use 'wbthomason/packer.nvim'

		-- Simple plugins can be specified as strings
		--use 'rstacruz/vim-closer'

		-- Local plugins can be included
		-- use '~/projects/personal/hover.nvim'

		-- Plugins can have post-install/update hooks
		-- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

		-- Post-install/update hook with neovim command
		-- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

		-- Post-install/update hook with call of vimscript function with argument
		-- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

		-- Use specific branch, dependency and run lua file after load
		-- use {
		--   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
		--   requires = {'kyazdani42/nvim-web-devicons'}
		-- }

		-- Use dependency and run lua function after load
		-- use {
		--   'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
		--   config = function() require('gitsigns').setup() end
		-- }

		-- -- You can specify multiple plugins in a single call
		-- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

		-- You can alias plugin names
		--use {'dracula/vim', as = 'dracula'}
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}
	use {
		'akinsho/bufferline.nvim', 
		tag = "v3.*", 
		requires = 'nvim-tree/nvim-web-devicons'
	}

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
	-- using packer.nvim
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
			
	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
				vim.cmd('colorscheme rose-pine')
		end
	})
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or        , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	
	}
	
	use 'tomasiser/vim-code-dark'

	end)
