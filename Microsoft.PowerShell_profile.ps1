if (Test-Path ./env.ps1)
{
  . ./env.ps1
}
if ([string]::IsNullOrEmpty($env:NVIM))
{
  exit;
}

function prompt
{
  $path = (Get-Location).Path -replace '\\', '/'
  $pathSegments = $path -split '/'
  $prefix = ""

  if ($pathSegments.Length -gt 3)
  {
    $pathSegments = $pathSegments[($pathSegments.Length - 2) .. ($pathSegments.Length - 1)]
    $prefix = '.../'
  }

  $path = $prefix + ($pathSegments -join '/')

  $gitbranch = (git symbolic-ref --short HEAD 2>$null) -replace '\s', ''

  $ESC = [char]27
  $gitbranchView = if ($gitbranch)
  {

    $gitstatus = (git status --porcelain 2>$null)
    if ($gitbranch -and ($gitstatus -match "^(M|A|D|R|C) "))
    {
      $gitcolor = '{0}[33m' -f $ESC
    } elseif ($gitbranch -and ($gitstatus -match "."))
    {
      $gitcolor = '{0}[31m' -f $ESC
    } else
    {
      $gitcolor = '{0}[32m' -f $ESC
    }
    ' {0}[34m({1}{2}{3}[34m)' -f $ESC, $gitcolor, $gitbranch, $ESC
  } else
  {
    ''
  }
  '{0}[32m➜ {1}[34m{2}{3}{4}[34m{5}[32m>{6}[37m ' -f $ESC, $ESC, $path, $gitbranchView, $ESC, $ESC, $ESC
}


function pwc
{
  $path = (Get-Location).ProviderPath
  Set-Clipboard $path
}



Set-PSReadlineOption -Colors @{
  Command = [System.ConsoleColor]::DarkGreen
  Comment = [System.ConsoleColor]::DarkGreen
  ContinuationPrompt = [System.ConsoleColor]::DarkYellow
  Default = [ConsoleColor]::DarkYellow
  Emphasis = [System.ConsoleColor]::DarkCyan
  Error = [System.ConsoleColor]::DarkRed
  InlinePrediction = [System.ConsoleColor]::White
  Keyword = [System.ConsoleColor]::DarkCyan
  Member = [System.ConsoleColor]::DarkYellow
  Operator = [System.ConsoleColor]::DarkYellow
  Parameter = [System.ConsoleColor]::DarkMagenta
  Type = [System.ConsoleColor]::DarkYellow
  Variable = [System.ConsoleColor]::DarkCyan
}
Set-PSReadLineOption -EditMode "Vi"

Import-Module Terminal-Icons
Remove-Alias ls 2>&1 | Out-Null
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
