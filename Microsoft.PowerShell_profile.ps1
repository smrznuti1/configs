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
  #$path = Split-Path -Leaf (Get-Location)
  $path = ((Get-Location) -split '\\')
  $prefix = ""
  if ($path.Length -ge 3)
  {
    $path = $path[($path.Length - 2) .. $path.Length]
    $prefix = '.../'
  }

  $path = $prefix + ($path -join '/')

  $gitbranch = (git branch --show-current)
  $ESC = [char]27
  '{0}[93m{1} {2}[93m({3}[92m{4}{5}[93m){6}[93m> ' -f $ESC, $path, $ESC, $ESC, $gitbranch, $ESC, $ESC
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

if (-not (Test-Path $profile_path\$oh_my_posh_theme))
{
  Invoke-RestMethod -Uri $git_location\$oh_my_posh_theme -OutFile $profile_path\$oh_my_posh_theme
}

oh-my-posh --init --shell pwsh --config $profile_path\$oh_my_posh_theme | Invoke-Expression
# oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\$oh_my_posh_theme | Invoke-Expression
# oh-my-posh --init --shell pwsh | Invoke-Expression
$modules = "Terminal-Icons"
Import-Module Terminal-Icons
#$modules | Import-Module
Remove-Alias ls 2>&1 | Out-Null
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

fastfetch
