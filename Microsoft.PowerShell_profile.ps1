# if ([string]::IsNullOrEmpty($env:NVIM)){
#   nvim -c ":term"
# }
#


function Import-AllModules{
  param(
    [Parameter(Position = 0, ValueFromPipeline=$true)]
    [string]$Module
  )
  process{
    Import-Module -Name $Module 2>&1 | Out-Null
    if (-not $?){
      Install-Module -Name $Module -Force 2>&1 | Out-Null
      Import-Module -Name $Module 2>&1 | Out-Null
    }
  }
}
function spwsh{
  $allArgs = $args -join ' '
  sudo pwsh -NoProfile -NonInteractive -NoLogo -Command $allArgs
}
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
function ListAll{
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$Path = "."
  )
  Get-ChildItem $Path | Select-Object -Property Name, FullName
}

$oh_my_posh_theme="tokyo.omp.json"
oh-my-posh --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tokyo.omp.json" | Invoke-Expression
$modules = "Terminal-Icons", "PsDrives", "PrettyLs"
$modules | Import-AllModules
Remove-Alias ls 2>&1 | Out-Null
foreach ($drive in $drives){
  New-PSDrive @drive | Out-Null
}

Register-ArgumentCompleter -CommandName Set-Location -ParameterName Path -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    Get-PSDrive | Where-Object { $_.Name -like "$wordToComplete*" } | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList $_.Name, $_.Name, 'ParameterValue', $_.Name
    }
}
