local null_ls = require("null-ls")

local lSsources = 
require("null-ls").setup({
  debug = true,
  sources = {
    null_ls.builtins.formatting.black.with({ filetypes = {"python"}, args = {"--quiet", "--fast", "--line-length", "100", "-"}}),
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
        "md",
        "txt",
      },
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
  end,
})
