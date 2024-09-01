# if ([string]::IsNullOrEmpty($env:NVIM)){
#   nvim -c ":term"
# }
#


function Import-AllModules
{
  param(
    [Parameter(Position = 0, ValueFromPipeline=$true)]
    [string]$Module
  )
  process
  {
    Import-Module -Name $Module 2>&1 | Out-Null
    if (-not $?)
    {
      Install-Module -Name $Module -Force 2>&1 | Out-Null
      Import-Module -Name $Module 2>&1 | Out-Null
    }
  }
}
function spwsh
{
  $allArgs = $args -join ' '
  sudo pwsh -NoProfile -NonInteractive -NoLogo -Command $allArgs
}
function prompt
{
  $path = Split-Path -Leaf (Get-Location)
  '{0}: ' -f $path
}
function gfci
{
  [CmdletBinding()]
  param(
    [Parameter(Position = 0)]
    [string]$path = "."
  )
  Get-ChildItem -Force $path | ForEach-Object { $_.FullName }
}

function pwc
{
  $path = (Get-Location).ProviderPath
  Set-Clipboard $path
}



Set-PSReadlineOption -Colors @{
  Command = [System.ConsoleColor]::Green
  Comment = [System.ConsoleColor]::DarkGreen
  ContinuationPrompt = [System.ConsoleColor]::Yellow
  Default = [ConsoleColor]::Yellow
  Emphasis = [System.ConsoleColor]::Cyan
  Error = [System.ConsoleColor]::Red
  InlinePrediction = [System.ConsoleColor]::White
  Keyword = [System.ConsoleColor]::Cyan
  Member = [System.ConsoleColor]::Yellow
  Operator = [System.ConsoleColor]::Yellow
  Parameter = [System.ConsoleColor]::Magenta
  Type = [System.ConsoleColor]::Yellow
  Variable = [System.ConsoleColor]::Cyan
}
Set-PSReadLineOption -EditMode "Vi"
function ListAll
{
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$Path = "."
  )
  Get-ChildItem $Path | Select-Object -Property Name, FullName
}

$git_location = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes"
$profile_path = (Split-Path -Parent $PROFILE)

# $oh_my_posh_theme="easy-term.omp.json"
# $oh_my_posh_theme="tokyo.omp.json"
$oh_my_posh_theme="tokyonight_storm.omp.json"

if (-not (Test-Path $profile_path\$oh_my_posh_theme)){
  Invoke-RestMethod -Uri $git_location\$oh_my_posh_theme -OutFile $profile_path\$oh_my_posh_theme
}

oh-my-posh --init --shell pwsh --config $profile_path\$oh_my_posh_theme | Invoke-Expression
# oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\$oh_my_posh_theme | Invoke-Expression
# oh-my-posh --init --shell pwsh | Invoke-Expression
$modules = "Terminal-Icons", "PsDrives", "RepoManager"
$modules | Import-AllModules
Remove-Alias ls 2>&1 | Out-Null
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
