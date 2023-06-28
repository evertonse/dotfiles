local M = {}

require 'custom.user.options'
--require 'custom.user.autocommands'

M.plugins = 'custom.plugins.plugins'
M.ui = require  'custom.user.ui'
M.mappings = require 'custom.user.mappings'


--vim.cmd("colorscheme vs")

return M
