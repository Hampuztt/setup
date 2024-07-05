local plugins = {
{
  "lervag/vimtex",
  config = function()
    vim.g.vimtex_view_method = 'zathura'  -- or 'mupdf', 'okular', etc.
  end
},

{
  "ekickx/clipboard-image.nvim",
  config = function()
    require('clipboard-image').setup({
      default = {
        img_dir = "images",
        img_name = function()
          return os.date('%Y-%m-%d-%H-%M-%S')
        end,
        affix = "![](%s)",
      },
      mark = {
        img_dir = "images",
        img_name = function()
          return os.date('%Y-%m-%d-%H-%M-%S')
        end,
        affix = "![](%s)",
      },
      paste_img = {
        img_dir = "images",
        img_name = function()
          return os.date('%Y-%m-%d-%H-%M-%S')
        end,
        affix = "![](%s)",
      },
    })
  end
},
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.lint"
    end
  },


 {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "harpoon file", },
      { "<leader><Tab>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
    },
  },
 {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python", "cpp", "c", "h", "html", "javascript"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
        "clangd",
        "clang-format",
        "codelldb",
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

}
-- Function to view images using chafa
function ViewImage(img_path)
  vim.cmd("silent !chafa --colors=256 " .. img_path)
end

-- Function to view PDF using zathura
function ViewPDF(pdf_path)
  vim.cmd("silent !zathura " .. pdf_path)
end
-- Autocommands
vim.api.nvim_create_autocmd({"BufReadPost"}, {
  pattern = "*.pdf",
  callback = function()
    ViewPDF(vim.fn.expand("<afile>"))
  end,
})

vim.api.nvim_create_autocmd({"BufReadPost"}, {
  pattern = {"*.png", "*.jpg", "*.jpeg", "*.gif"},
  callback = function()
    ViewImage(vim.fn.expand("<afile>"))
  end,
})

return plugins
