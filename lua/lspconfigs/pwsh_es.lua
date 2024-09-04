local lspconfig = require "lspconfig"
local bundle_path = "~/Lsp/PowerShellEditorServices"
local on_attach = require("astronvim.utils.lsp").on_attach
local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.powershell_es.setup {
    capabilities = default_capabilities,
    on_attach = on_attach,
    bundle_path = bundle_path,
    filetypes = {"ps1"},
    init_options = {enableProfileLoading = false}
}
