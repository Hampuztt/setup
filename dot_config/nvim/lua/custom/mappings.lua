local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    -- Custom key mappings
    ["<C-d>"] = { "<C-d>zz", "scroll down and center" },
    ["<C-u>"] = { "<C-u>zz", "scroll up and center" },
    ["n"] = { "nzzzv", "next search match and center" },
    ["N"] = { "Nzzzv", "previous search match and center" },
    ["<leader>h"] = { "<cmd> ClangdSwitchSourceHeader <CR>", "switch between source and header"},
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "move selected lines down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "move selected lines up" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>",
    "Add breakpoint at line",
  },
  ["<F5>"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function ()
        require('dap-python').test_method( )
      end
    }
  }
}



-- M.harpoon = {
--   n = {
--     ["<leader>a"] = {
--       function()
--         local harpoon = require "harpoon"
--         harpoon:list():add()
--       end,
--       "󱡁 Harpoon Add file",
--     },
--     ["<leader>ta"] = { "<CMD>Telescope harpoon marks<CR>", "󱡀 Toggle quick menu" },
--     ["<leader><Tab>"] = {
--       function()
--         local harpoon = require "harpoon"
--         harpoon.ui:toggle_quick_menu(harpoon:list())
--         print(harpoon:list())
--       end,
--       "󱠿 Harpoon Menu",
--     },
--     ["<leader>1"] = {
--       function()
--         local harpoon = require "harpoon"
--         harpoon:list():select(1)
--       end,
--       "󱪼 Navigate to file 1",
--     },
--     ["<leader>2"] = {
--       function()
--         local harpoon = require "harpoon"
--         harpoon:list():select(2)
--       end,
--       "󱪽 Navigate to file 2",
--     },
--     ["<leader>3"] = {
--       function()
--         local harpoon = require "harpoon"
--         harpoon:list():select(3)
--       end,
--       "󱪾 Navigate to file 3",
--     },
--     ["<leader>4"] = {
--       function()
--         local harpoon = require "harpoon"
--         harpoon:list():select(4)
--       end,
--       "󱪿 Navigate to file 4",
--     },
--   },
-- }
return M
