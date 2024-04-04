# if ([string]::IsNullOrEmpty($env:NVIM)){
#   nvim -c ":term"
# }
#


function prompt {
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
  $path = Get-Location
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
function ListAll{
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$Path = "."
  )
  Get-ChildItem $Path | Select-Object -Property Name, FullName
}
Set-Alias -Name ls -Value ListAll
# New-PsDrives 2>&1 | Out-Null

$oh_my_posh_theme="tokyo.omp.json"
oh-my-posh --init --shell pwsh --config "C:\Users\sesa719972\AppData\Local\Programs\oh-my-posh\themes\$oh_my_posh_theme" | Invoke-Expression
Import-Module -Name Terminal-Icons 2>&1 | Out-Null
Import-Module -Name PsDrives 2>&1 | Out-Null
