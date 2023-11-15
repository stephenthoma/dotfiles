local status = require("setup.lsp-status")
local lsp_status = require("lsp-status")
status.activate()

-- LSP this is needed for LSP completions in CSS along with the snippets plugin
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- LSP Server config
require("lspconfig").pyright.setup({
  cmd={"/Users/sthoma/.pyenv/versions/3.10.11/bin/pyright-langserver", "--stdio"},
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})
require("lspconfig").cssls.setup({
  cmd = { "vscode-css-language-server", "--stdio" },
  settings = {
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

-- tsserver
local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.uri, '%.d.ts') == nil

end

require("lspconfig").tsserver.setup({
  root_dir = function() return vim.loop.cwd() end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
  handlers = {
    ['textDocument/definition'] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
    end
  }
})
require("lspconfig").html.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})


-- LSP Prevents inline buffer annotations
vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})

local signs = {
  Error = "ﰸ",
  Warn = "",
  Hint = "",
  Info = "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float()]])
vim.cmd([[autocmd BufRead,BufNewFile */node_modules/* lua vim.diagnostic.disable(0)]])

