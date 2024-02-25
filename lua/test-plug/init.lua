lspconfig = require("lspconfig")
lspconfig.pylsp.setup {
on_attach = custom_attach,
settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = false},
        autopep8 = { enabled = true},
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = false, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = true },
        -- type checker
        pylsp_mypy = { enabled = true,
        live_mode = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true},
        -- import sorting
        pyls_isort = { enabled = true },
        rope_autoimport = { enabled = false,
        completions = {enabled = true},
        code_actions = {enabled = true }},
    },
    },
},
flags = {
    debounce_text_changes = 200,
},
capabilities = capabilities,
}





-- lspconfig.pyright.setup{
-- on_attach = custom_attach,
--   settings = {
--     pyright = {
--       analysis = {
--         autoImportCompletions = true,
--       }
--     }
--   }
-- }
