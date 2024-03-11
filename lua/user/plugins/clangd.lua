return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- if you use nvim-cmp
  config = function()
    require("lspconfig").clangd.setup {
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
  end,
}
