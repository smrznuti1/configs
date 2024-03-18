local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"

if not configs.basedpyright_lsp then
  configs.basedpyright_lsp = {
    default_config = {
      cmd = { "basedpyright-langserver", "--stdio" },
      root_dir = lspconfig.util.root_pattern ".git",
      filetypes = { "python" },
      settings = {
        verboseOutput = true,
        autoImportCompletion = true,
        python = {
          analysis = {
            -- typeCheckingMode = "strict",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
            indexing = true,
          },
        },
      },
    },
  }
end
lspconfig.basedpyright_lsp.setup {}
