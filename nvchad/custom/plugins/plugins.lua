local overrides = require('custom.plugins.opts')

local M  = {}

M.plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
    { "windwp/nvim-autopairs",                  }, -- Autopairs, integrates with both cmp and treesitter
    { "numToStr/Comment.nvim",                  },
    -- MAYBE  file browser instead https://github.com/nvim-telescope/telescope-file-browser.nvim
    { "moll/vim-bbye",                          }, -- Avoid messing with windwos layouts when closing buffers
    --{ "ahmedkhalf/project.nvim",                }, -- Discover your projects Automatically
    { "lewis6991/impatient.nvim",               },
    { "lukas-reineke/indent-blankline.nvim",    }, -- Show identations lines
    { "goolord/alpha-nvim", opts = function() require 'custom.plugins.config.alpha' end,                     }, -- UI Library with dashboard
    { "folke/which-key.nvim",opts = function() require 'custom.plugins.config.whichkey' end,                 }, -- Show Key popup

    -->> Cmp 
    -->> LSP
    {
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
        },
    },
    { "onsails/lspkind.nvim",}, -- better lsp cmp icons
    { "jose-elias-alvarez/null-ls.nvim",        }, -- for formatters and linters
    { "RRethy/vim-illuminate",                  },
    { "folke/trouble.nvim",                   }, -- LPS Diagnostic with colors and shit
    { 'folke/lsp-colors.nvim',                }, -- LSP colors that might be missings
    -- { 'jackguo380/vim-lsp-cxx-highlight',     }, -- LSP based cpp highlighting
    -->> Telescope
    { 
        "nvim-telescope/telescope.nvim",   
        opts = overrides.telescope,          
    },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', 
        run = 'make', 
        cond = vim.fn.executable 'make' == 1 
    },
    {'NvChad/nvim-colorizer.lua',             },
        
    -->> Treesitter
    --[[
    {
            "nvim-treesitter/nvim-treesitter",
        -- nothings on Jan 2, 2023
        --"d31c71c959348b7b15f7e69608a47aea05ed7bc6" -- nothings on Dec 14, 2022
        --"256802258084fcf6c7011dae4c3fbfaaf4b61518" -- nothings on Dec 1, 2022
        --"4b900527045c49af5f43291d2cb13ae27a3bc7be" -- Nov 30, 2022
        --"d1eaf23c9ec9aca91e219ed82ae98c96d93dd407" -- 29 nov 2022
        --"1a767376cdb968f43af690ccac7001d2efbefb87" --ObserverOfTime nothingted on Nov 26, 2022
        --"79705a1f80297d1f3178d2b30423760c060afa4a" --highlights(cpp):  more specific groups ObserverOfTime nothingted on Nov 26, 2022
        --"7ce62670b2e0946e3f586f3f07a584f642b02b9b" --highlights(c):  more specific groups 
        --"00b42ac6d4c852d34619eaf2ea822266588d75e3" --[Does Not Work] @type.qualifier and @storageclass on Nov 6, 2022
        --"ae104a057fc4164af8884f0b5540c79be95f5fc5"  --[does not work] fix: update scheme queries to parser change
        --"1fa45d8c793282d9a65044666e977220f91a2dd7"  --web-flow authored and clason nothingted on Nov 6, 2022
        --"dd89cafd2bc5ddbb201b6b1ea72ecd11acbe4e31" -- nov 5 2022
        --"a4b10b60c16ca141ca1dae538479889dd6932270" -- nov 2 2022
        --"c6992f69d303cee0b43fd59125cb7afb0262d8fe" -- [Does Not Work]nov 1 2022 Update lockfile.jason 
        --"e7bdcee167ae41295a3e99ad460ae80d2bb961d7" -- [Turning Point][Does Not Work]nov 1 2022 lua: update queries

    ------  THE nothing BELLOW --------------
        --"5f85a0a2b5c8e385c1232333e50c55ebdd0e0791" -- [Works] one nothing later and it stops working help: update queries nov 1 2022
    -------  THE nothing ABOVE --------------

        --"7709eb4b47b8ee19e760aa2771c5735fda2798e1" -- [Works]Disable folding at startup nov 1
        -- "80503a99104e461599ef8810a64bce1b6d235f6a" -- [Works]31 oct 2022
        --"287ffdccc1dd7ed017d844a4fad069fd3340fa94" --[Works] Add regex injections for php (Verified) on Oct 28, 2022
        --"c9241287719ccd38741850765649a25b09bdb4c2" --[Works] highlights(python): add "except*" Oct 25, 2022
        --"9b43ab819c756f01d2977cd481bdcaead6867174" --highlights:  @preproc where appropriate Oct 15, 2022
        --"b945aa0aab03d4817a42cbcb27059217d8e56ed8" --highlights(c): highlight standard streams on Oct 15, 2022
        --"179a06bc8b4b028960dc105feceb5a4b1cbcb41d" --style: fix code styling according to Stylua  Oct 3, 2022
        --"8e763332b7bf7b3a426fd8707b7f5aa85823a5ac" --[Works] nothings [stable] - works with every plugin] Oct 2, 2022 
        },
    --]]

    --Optionally  mine https://github.com/evertonse/nvim-treesitter, removed bug with windows that wasnt adressed nor have I seen any issues opened
    --{'evertonse/nvim-treesitter'},
    {"JoosepAlviste/nvim-ts-context-commentstring",     }, -- Nice Vim commenting --  context_commentstring { enable = true },
    -- {'David-Kunz/markid',                                                                       }, -- Every identifier has the same color
    {'nvim-treesitter/playground',                      },

    -- Argument Coloring
    -- {'octol/vim-cpp-enhanced-highlight',                }, -- still haven't d but adds cpp keywords for highlight tweak even further
    {'m-demare/hlargs.nvim',                            },

        -->> Git
    {"lewis6991/gitsigns.nvim",                         },

        -->> Colorschemes
    -- 'marko-cerovac/material.nvim'
    -- { "folke/tokyonight.nvim",  },
    -- { "lunarvim/darkplus.nvim",  },
    -- 'tomasiser/vim-code-dark'
    -- 'shaunsingh/nord.nvim'
    -- Another vs code theme:
    -- for more options see: https://github.com/Mofiqul/vscode.nvim
    -- 'Mofiqul/vscode.nvim'

    --[[ 
        Using my fork of Mofiqul vscode nvim theme, 
        but my theme is Focusing on Visual Studio Theme, rather tha vs code
    --]]
    -- {'evertonse/vs.nvim', branch = "base",            }, --  this for bare minimum, first commit and base branch
    {'evertonse/vs.nvim', branch = "dev"},

    -->> Utils
    {'dstein64/vim-startuptime',                      },
    {'tpope/vim-surround',                            },

    { --https://github.com/andymass/vim-matchup
        'andymass/vim-matchup',
        setup = function()
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
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}

return {}
