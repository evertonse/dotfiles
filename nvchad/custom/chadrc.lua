local M = {}

M.plugins = 'custom.plugins.plugins'

M.mappings = require 'custom.user.mappings'
require 'custom.user.options'
M.options = require 'custom.user.options'
M.ui = require  'custom.user.ui'

return M
