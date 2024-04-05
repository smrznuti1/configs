local lspconfig = require "lspconfig"
local bundle_path = "C:/LSP-s/PowerShellEditorServices"
lspconfig.powershell_es.setup {
  bundle_path = bundle_path,
  filetypes = { "ps1" },
  init_options = {
    enableProfileLoading = false,
  },
}
