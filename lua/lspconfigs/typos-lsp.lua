local lspconfig = require "lspconfig"
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("astronvim.utils.lsp").on_attach
lspconfig.typos_lsp.setup {
  -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
  -- cmd_env = { RUST_LOG = "error" },
  capabilities = lsp_capabilities,
  on_attach = on_attach,
  init_options = {
    -- Custom config. Used together with any workspace config files, taking precedence for
    -- settings declared in both. Equivalent to the typos `--config` cli argument.
    -- config = "~/code/typos-lsp/crates/typos-lsp/tests/typos.toml",
    -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
    -- Defaults to error.
    diagnosticSeverity = "Error",
  },
}
