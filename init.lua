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

vim.opt.shell = "pwsh"
vim.opt.shellcmdflag =
  "-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.api.nvim_create_user_command("Pterm", "term pwsh", {})
vim.api.nvim_create_user_command("PT", "term pwsh", {})
vim.api.nvim_create_user_command("Uterm", "term wsl.exe", {})
vim.api.nvim_create_user_command("UT", "term wsl.exe", {})
vim.api.nvim_create_user_command("BDAll", "%bd! | e#", {})
vim.api.nvim_create_user_command("NT", "bd! % | term", {})
vim.api.nvim_create_user_command("NUT", "bd! % | Uterm", {})

require("mason-null-ls").setup {
  ensure_installed = {
    "lua-language-server",
    "texlab",
    "latexindent",
    "actionlint",
    "bibtex-tidy ",
    "alex",
    "commitlint",
    "debugpy",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "fixjson",
    "gitleaks",
    "isort",
    "prettier",
    "pyflakes",
    "taplo",
    "typos",
    "yaml-language-server",
    "yamlfix",
    "cmakelang",
    "cmake-language-server",
    "bash-language-server ",
    "powershell-editor-services",
    "shellcheck",
    "beautysh",
    "ansible-lint",
    "ansible-language-server",
  },
  automatic_installation = false,
  handlers = {},
}

vim.opt.wrap = true

require("notify").setup {
  background_colour = "#000000",
}

require("distant"):setup()

vim.api.nvim_create_user_command("TT", "TransparentToggle", {})

require "netman"
require "test-plug"
