local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

-- Function to get the correct Python interpreter
local function get_python_path()
  return "/home/hampuz/anaconda3/bin/python"
end

lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    -- Enable logging
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
    client.config.settings = client.config.settings or {}
    client.config.settings.pyright = client.config.settings.pyright or {}
    client.config.settings.pyright.trace = { server = "verbose" }

    -- Enable LSP logging
    vim.lsp.set_log_level("debug")

    -- Call the original on_attach function
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  filetypes = {"python"},
  settings = {
    python = {
      analysis = {
        extraPaths = {"/home/hampuz/anaconda3/lib/python3.11/site-packages/apytypes/"},  -- Add extra paths if needed
        useLibraryCodeForTypes = true  -- Ensure the LSP uses library code for type analysis
      },
      pythonPath = get_python_path(),
    }
  }
})

lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})



local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}

-- HTML Server Setup
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    html = {
      format = {
        wrapLineLength = 5000,
        unformatted = "code,pre,em,strong,span"
      }
    }
  }
}
