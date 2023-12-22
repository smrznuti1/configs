if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end

for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      ("Error setting up colorscheme: `%s`"):format(astronvim.default_colorscheme),
      vim.log.levels.ERROR
    )
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

vim.opt.shell = 'powershell.exe'
vim.opt.shellcmdflag = '-NonInteractive -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
vim.opt.shellxquote = ''
vim.opt.shellquote = ''
vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s'
vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s'

--vim.opt.shell = 'wsl.exe'
--vim.opt.shellcmdflag = 'ubuntu.exe run '
--vim.opt.shellxquote = ''
--vim.opt.shellquote = ''

vim.api.nvim_create_user_command("Pterm", 'term powershell.exe', {})
vim.api.nvim_create_user_command("PT", 'term powershell.exe', {})
vim.api.nvim_create_user_command("Uterm", 'term wsl.exe', {})
vim.api.nvim_create_user_command("UT", 'term wsl.exe', {})
vim.api.nvim_create_user_command("BDAll", '%bd! | e#', {})
vim.api.nvim_create_user_command("NT", 'bd! % | term', {})
vim.api.nvim_create_user_command("NUT", 'bd! % | Uterm', {})



--require'lspconfig'.pyright.setup{}



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
require("lspconfig").clangd.setup({ capabilities = capabilities })
require("mason-null-ls").setup({
    ensure_installed = {
  'lua-language-server',
  'texlab',
  'latexindent',
  'actionlint',
  'bibtex-tidy ',
  'alex',
  'clangd',
  'commitlint',
  'debugpy',
  'docker-compose-language-service',
  'dockerfile-language-server',
  'fixjson',
  'gitleaks',
  'isort',
  'prettier',
  'pyflakes',
  'python-lsp-server',
  'taplo',
  'typos',
  'yaml-language-server',
  'yamlfix',
  'cmakelang',
  'cmake-language-server',
  'bash-language-server ',
  'powershell-editor-services',
  'shellcheck',
  'beautysh',
  'ansible-lint',
  'ansible-language-server',
    },
    automatic_installation = false,
    handlers = {},
})

vim.opt.wrap = true

--vim.cmd.colorscheme "catppuccin"

require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})

require("notify").setup({
  background_colour = "#000000",
})

require("distant"):setup()


vim.api.nvim_create_user_command("TT", 'TransparentToggle', {})


