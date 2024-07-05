---@type ChadrcConfig
local M = {}

M.ui = {
    transparency = false,
  --theme = "tokyonight",
  theme = 'catppuccin',
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
vim.opt.clipboard = "unnamedplus"

-- Defer loading harpoon_utils to ensure all plugins are initialized
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     print("VimEnter event triggered")
--     local project_utils = require("custom.harpoon_utils")
--     print("harpoon_utils required")
--     if vim.fn.getcwd() == vim.fn.expand("~") then
--       print("Setting up projects")
--       project_utils.setup_projects()
--     else
--       print("Current directory does not match")
--     end
--   end
-- })

return M

