local overrides = require('custom.plugins.opts')

local M  = {}

M.plugins = {

    { "moll/vim-bbye", lazy = false}, -- Avoid messing with windwos layouts when closing buffers
    {
      "lewis6991/impatient.nvim",
      lazy=false,
      config = function()
        require('impatient')
      end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
        config = function()
          -- This is where you modify the settings for lsp-zero
          -- Note: autocompletion settings will not take effect

          --require('lsp-zero.settings').preset({})
          require "custom.plugins.configs.lsp_zero"
        end,
        dependencies = {
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
        },
    },
    {'famiu/bufdelete.nvim'},
    {
      'neovim/nvim-lspconfig',
      cmd = 'LspInfo',
      event = {'BufReadPre', 'BufNewFile'},
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {'williamboman/mason-lspconfig.nvim'},
        {
          'williamboman/mason.nvim',
          build = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
      },
      config = function()
        -- This is where all the LSP shenanigans will live
        require "plugins.configs.lspconfig"
        local lsp = require('lsp-zero')

        lsp.on_attach(function(client, bufnr)
          lsp.default_keymaps({buffer = bufnr})
        end)

        -- (Optional) Configure lua language server for neovim
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup()

      end
    },
    { "onsails/lspkind.nvim",}, -- better lsp cmp icons
    {
      "jose-elias-alvarez/null-ls.nvim", 
      config = function() 
        require 'custom.plugins.configs.null-ls'
      end
    }, -- for formatters and linters
    { "RRethy/vim-illuminate",                  },
    { "folke/trouble.nvim",                   }, -- LPS Diagnostic with colors and shit
    { 'folke/lsp-colors.nvim',                }, -- LSP colors that might be missings
    -- { 'jackguo380/vim-lsp-cxx-highlight',     }, -- LSP based cpp highlighting
    -->> Telescope
    {
        "nvim-telescope/telescope.nvim",
        opts = overrides.telescope,
    },

    -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', 
        run = 'make', 
        cond = vim.fn.executable 'make' == 1 
    },

    --Optionally  mine https://github.com/evertonse/nvim-treesitter, removed bug with windows that wasnt adressed nor have I seen any issues opened
    {"JoosepAlviste/nvim-ts-context-commentstring",     }, -- Nice Vim commenting --  context_commentstring { enable = true },
    -- {'David-Kunz/markid',                                                                       }, -- Every identifier has the same color
    {
      'nvim-treesitter/playground', 
      lazy=false,
      config = function() 
        require "nvim-treesitter.configs".setup {
          playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
              toggle_query_editor = 'o',
              toggle_hl_groups = 'i',
              toggle_injected_languages = 't',
              toggle_anonymous_nodes = 'a',
              toggle_language_display = 'I',
              focus_language = 'f',
              unfocus_language = 'F',
              update = 'R',
              goto_node = '<cr>',
              show_help = '?',
            },
          },
          query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {"BufWrite", "CursorHold"},
          },
      }
      end, 
      enable=true                      
    },

    -- Argument Coloring
    -- {'octol/vim-cpp-enhanced-highlight',                }, -- still haven't d but adds cpp keywords for highlight tweak even further
    {
      'm-demare/hlargs.nvim',
      lazy=false,
      opts = overrides.hlargs,
      config = function() require "custom.plugins.configs.hlargs" end
    },
        -->> Colorschemes
     {'marko-cerovac/material.nvim'},
     { "folke/tokyonight.nvim",  },
    --[[ 
        Using my fork of Mofiqul vscode nvim theme, 
        but my theme is Focusing on Visual Studio Theme, rather tha vs code
    --]]
    -- {'evertonse/vs.nvim', branch = "base",            }, --  this for bare minimum, first commit and base branch
    {
      'evertonse/vs.nvim', branch = "dev",
      lazy=true,
      config = function()
          local status_ok, _ = pcall(vim.cmd, "colorscheme vs")
          if not status_ok then
            return
          end
          --vim.api.nvim_set_hl(0,'Normal',{bg = "none"})
          vim.api.nvim_set_hl(0,'NormalFloat',{bg = "none"})
      end
    },

    -->> Utils
    {'dstein64/vim-startuptime',                      },
    {'tpope/vim-surround',                            },

    { --https://github.com/andymass/vim-matchup
        'andymass/vim-matchup',
        config = function()
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = "popup"}
        end
    },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      --vim.cmd "colorscheme vs"
      return overrides.nvimtree;
    end,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}

return M.plugins
