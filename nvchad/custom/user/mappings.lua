local term_opts = { silent = true }
local noremap_opts = { noremap = true, silent = true }
local nowait_opts = { noremap = true, silent = true, nowait = true }

local M = {}
-- add this table only when you want to disable default keys
M.disabled = {
  n = {
    ["<leader>fo"] = "",
    ["<leader>fa"] = "",
    ["<leader>fb"] = "",
    ["<leader>fc"] = "",
    ["<leader>fd"] = "",
    ["<leader>fe"] = "",
    ["<leader>ff"] = "",
    ["<leader>fg"] = "",
    ["<leader>fh"] = "",
    ["<leader>fi"] = "",
    ["<leader>fj"] = "",
    ["<leader>fl"] = "",
    ["<leader>fm"] = "",
    ["<leader>fn"] = "",
    ["<leader>fp"] = "",
    ["<leader>fq"] = "",
    ["<leader>fr"] = "",
    ["<leader>fs"] = "",
    ["<leader>ft"] = "",
    ["<leader>fu"] = "",
    ["<leader>fv"] = "",
    ["<leader>fx"] = "",
    ["<leader>fz"] = "",

    ["<leader>ch"] = "",
    ["<leader>ca"] = "",
    ["<leader>cc"] = "",
    -- which-key
    ["<leader>wK"] = "",
    ["<leader>wk"] = "",
    ["<leader>fw"] = "",
    ["<leader>tk"] = "",
    -- bufferline
    ["<leader>x"] = "",
    ["<S-b>"] = "",
    -- comment
    ["<leader>/"] = "",
    -- lspconfig
    ["d]"] = "",
    ["[d"] = "",
    ["<leader>gt"] = "",
    ["<leader>cm"] = "",
    -- nvterm
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    -- nvimtree
    ["<leader>e"] = "",
    -- bufferline
    ["<leader>b"] = "",
  },
  v = {
    -- comment
    ["<leader>/"] = "",
  },
  t = {
    -- nvterm
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}
M.general = {
    n = {
   
    ["<Esc><Esc>"] = { ":noh <CR>", "Clear highlights" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<leader><C-a>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>nvc"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
        ['<M-Up>'] = { "ddkP",opts = noremap_opts }, --// Moving the line up
        ['<M-Down>'] = { "ddjP",opts = noremap_opts}, -- // Moving the line down
        ["<M-[>"] = {":resize -2<CR>", opts = noremap_opts},
        ["<M-]>"] = {":resize +2<CR>", opts = noremap_opts},
        ["<M-,>"] = {":vertical resize -2<CR>", opts = noremap_opts},
        ["<M-.>"] = {":vertical resize +2<CR>", opts = noremap_opts},
        -- Navigate buffers
        --- behave like other capitals
        ["Y"] = {"y$",opts = noremap_opts},
        ["<S-l>"] = {":bnext<CR>", opts = noremap_opts},
        ["<S-h>"] = {":bprevious<CR>", opts = noremap_opts},

        -- Move text up and down
        ["<A-j>"] = {"<Esc>:m .+1<CR>==g", opts = noremap_opts},
        ["<A-k>"] = {"<Esc>:m .-2<CR>==g", opts = noremap_opts},
        -- >> move fast with crtl Movinge
        ['<C-h>'] =  {"b", opts = noremap_opts},
        ['<C-l>'] =  {"e", opts = noremap_opts},

        ['<C-Left>'] =  {"b",opts = noremap_opts},
        ['<C-Right>'] =  {"e",opts = noremap_opts},

        ['<C-j>'] =  {"}",opts = noremap_opts},
        ['<C-k>'] =  {"{",opts = noremap_opts},

        ["<leader>w"] = { ':w<CR>',opts = noremap_opts},
        ["<leader>q"] = { ':q<CR>',opts = noremap_opts},
        ["<leader>c"] = { ':Bdelete!<CR>',opts = noremap_opts},
        -- >> Clip Board option 
        ["<leader>y"] = { '"_y',opts = noremap_opts},
        ["<leader>Y"] = { '"_Y',opts = noremap_opts},
        ['<C-Up>'] =  {"{", opts = noremap_opts},
        ['<C-Down>'] =  {"}",opts = noremap_opts},
        -- >> Shift Selection :
        ['<S-Up>']  = {  "v<Up>",opts = noremap_opts},
        ['<S-Down>'] = {  "v<Down>",opts = noremap_opts},
        ['<S-Left>'] = {  "<Left>v",opts = noremap_opts},
        ['<S-Right>'] = {  "v",opts = noremap_opts},
        ['<M-Left>'] = {  "<C-o>",opts = noremap_opts},
        ['<M-Right>'] = {  "<C-i>",opts = noremap_opts},
        ["<C-d>"] = {  "<C-d>zz",opts = noremap_opts},
        ["<C-u>"] = {  "<C-u>zz",opts = noremap_opts},
        ["n"] = { "nzz" ,opts = noremap_opts},
        ["N"] = { "Nzz" ,opts = noremap_opts},
        ["Q"] = { "qq",opts = noremap_opts},
        ['[d'] ={  vim.diagnostic.goto_prev,opts = noremap_opts},
        [']d'] ={  vim.diagnostic.goto_next,opts = noremap_opts},
        ['U'] ={ '<C-r>'},
        ['<leader>re'] ={  'yW:%s/<C-r>*/<C-r>*/gc<Left><Left><Left><Down>', opts = noremap_opts},
        ['<leader>ra'] ={  'yW:%s/<C-r>*/<C-r>*/<Left><Down>', opts = noremap_opts},
        ["<leader>se"] ={  "yW/<C-r>*<Down>",opts = noremap_opts},

        ["<leader>d"]={ "\"_d",opts = noremap_opts},
        ["<leader>D"]={ '"_D',opts = noremap_opts},
        ["<leader>p"]={ '"_p',opts = noremap_opts},
        ["x"]={ '"_x',opts = noremap_opts},
        ["ge"]={ "G", opts = noremap_opts},
        ["gh"]={ "0", opts = noremap_opts},
        ["gl"]={ "$", opts = noremap_opts},
        ["<leader>s"]={ "\"_s",opts = noremap_opts},
    },

    i = {
      -- go to  beginning and end
      ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
      ["<C-e>"] = { "<End>", "End of line" },

      -- navigate within insert mode
      ["<C-h>"] = { "<Left>", "Move left" },
      ["<C-l>"] = { "<Right>", "Move right" },
      ["<C-j>"] = { "<Down>", "Move down" },
      ["<C-k>"] = { "<Up>", "Move up" },
        -- Insert --
        -- Press jk fast to exit insert mode 
        ["jk"] = { "<ESC>", opts = noremap_opts},
        ["kj"] = { "<ESC>", opts = noremap_opts},
        ['<C-Up>'] = {    "<C-o>{",opts = noremap_opts},
        ['<C-Down>'] = {  "<C-o>}",opts = noremap_opts},
        ['<C-Left>'] = {    "<C-o>b",      term_opts = noremap_opts},
        ['<C-Right>'] = {  "<C-o>e<Right>",term_opts = noremap_opts},
        ['<C-v>'] = { "<C-o><C-v>",opts = noremap_opts},
        -- << Move fast with crtl move,
        ['<S-Up>'] = { "<C-o>v<Up>",opts = noremap_opts},
        ['<S-Down>'] = { "<C-o>v<Down>",opts = noremap_opts},
        ['<S-Left>'] = { "<Left><C-o>v",opts = noremap_opts},
        ['<S-Right>'] = { "<C-o>v",opts = noremap_opts},
        ["<C-c>"] = { "<Esc>",opts = noremap_opts},
        ['<M-U>'] = {'<C-o><C-r>'},
    },
    v = {
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        [ "J"] = { ":m '>+1<CR>gv=gv",opts = noremap_opts},
        [ "K"] = { ":m '<-2<CR>gv=gv",opts = noremap_opts},
        -- Visual --
        -- Stay in indent mode
        [ "<"] = { "<gv", opts = noremap_opts},
        [ ">"] = { ">gv", opts = noremap_opts},

        -- Move text up and down
        [ "<A-j>"] = { ":m .+1<CR>==", opts = noremap_opts},
        [ "<A-k>"] = { ":m .-2<CR>==", opts = noremap_opts},
        [ "p"] = { '"_dP', opts = noremap_opts},

        [ '<C-h>'] = { "b", },
        [ '<C-l>'] = { "e", },

        [ '<C-Left>'] = { "b",},
        [ '<C-Right>'] = { "e",},

        [ '<C-j>'] = { "}",opts = noremap_opts},
        [ '<C-k>'] = { "{",opts = noremap_opts},

        [ '<C-Up>'] = { "{",opts = noremap_opts},
        [ '<C-Down>'] = { "}",opts = noremap_opts},


        [ '<M-Up>'] = { ":m '<-2<CR>gv=gv",opts = noremap_opts},
        [ '<M-Down'] = { ":m '>+2<CR>gv=gv",opts = noremap_opts},


        [ "<leader>y"] = { '"_y',opts = noremap_opts},
        [ '<leader>re'] = {  'y:%s/<C-r>*/<C-r>*/g<Left><Left><Left><Left><Down>', opts = noremap_opts},

        ["<A-Up>"] = { ":move '<-2<CR>gv-gv", opts = noremap_opts},

        ['<S-Up>'] = { "<Up>",opts = noremap_opts},
        ['<S-Down>'] = { "<Down>",opts = noremap_opts},
        ['<S-Left>'] = { "<Left>",opts = noremap_opts},
        ['<S-Right>'] = { "<Right>",opts = noremap_opts},
        -- << Shift Selection :
        ["<leader>d"]={ "\"_d",opts = noremap_opts},
        ["<leader>D"]={ '"_D',opts = noremap_opts},
        ["<leader>p"]={ '"_p',opts = noremap_opts},
        ["x"]={ '"_x',opts = noremap_opts},
        ["ge"]={ "G", opts = noremap_opts},
        ["gh"]={ "0", opts = noremap_opts},
        ["gl"]={ "$", opts = noremap_opts},
        ["<leader>s"]={ "\"_s",opts = noremap_opts},
    },
    x = {
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
      -- Don't copy the replaced text after pasting in visual mode
      -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
      ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },

        [ "J"]={ ":move '>+1<CR>gv-gv", opts = noremap_opts},
        [ "K"]={ ":move '<-2<CR>gv-gv", opts = noremap_opts},
        [ "<A-j>"]={ ":move '>+1<CR>gv-gv", opts = noremap_opts},
        [ "<A-k>"]={ ":move '<-2<CR>gv-gv", opts = noremap_opts},
        [ "<A-Down>"]={ ":move '>+1<CR>gv-gv", opts = noremap_opts},
        ['<Space>'] = {'<Nop>', opts = { silent = true }},
        ["<leader>d"]={ "\"_d",opts = noremap_opts},
        ["<leader>D"]={ '"_D',opts = noremap_opts},
        ["<leader>p"]={ '"_p',opts = noremap_opts},
        ["x"]={ '"_x',opts = noremap_opts},
        ["ge"]={ "G", opts = noremap_opts},
        ["gh"]={ "0", opts = noremap_opts},
        ["gl"]={ "$", opts = noremap_opts},
    },

    t = {
        ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
        ["<C-h>"] = { "<C-\\><C-N><C-w>h", opts = term_opts},
        ["<C-j>"] = { "<C-\\><C-N><C-w>j", opts = term_opts},
        ["<C-k>"] = { "<C-\\><C-N><C-w>k", opts = term_opts},
        ["<C-l>"] = { "<C-\\><C-N><C-w>l", opts = term_opts},
    },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>lca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>of"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" }})
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" }})
      end,
      "Goto next",
    },

    ["<leader>loc"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<leader>lwa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>lwr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>lwl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
    ["<leader>E"] = { "<cmd> NvimTreeFindFile <CR>", "Focus Current file" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>f"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>af"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>F"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>b"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>tf"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>of"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>bf"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>gcm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        --local input = vim.fn.input "WhichKey: "
        --vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>jc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    --["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}



return M
