lspconfig = require("lspconfig")
default_capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.clangd.setup{
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
}
