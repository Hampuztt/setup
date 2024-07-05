local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require('null-ls')

local opts = {
  sources = {
  null_ls.builtins.diagnostics.mypy.with({
    extra_args = function()
    local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
    return { "--python-executable", virtual .. "/bin/python3" }
    end,
}),
    -- null_ls.builtins.formatting.black.with({ filetypes = { "python" } }),
    null_ls.builtins.formatting.ruff.with({ filetypes = { "python" } }),
    -- null_ls.builtins.diagnostics.mypy.with({ filetypes = { "python" } }),
    null_ls.builtins.diagnostics.ruff.with({ filetypes = { "python" } }),
    null_ls.builtins.formatting.clang_format.with({ filetypes = { "cpp", "c", "h" } }),

null_ls.builtins.diagnostics.eslint.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      command = "eslint",
      args = { "--stdin", "--stdin-filename", "$FILENAME", "--format", "json" },
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "css" },
      command = "prettier",
      args = { "--stdin-filepath", "$FILENAME" },
    }),
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
return opts
