$env:DISPLAY = ":1.0"
$env:LIBGL_ALWAYS_INDIRECT = "0"
$env:PULSE_SERVER="tcp:$(ip route | grep default | awk '{print $3}')"
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
  #$gitstatus = (git status --porcelain 2>$null)
  $gitstatus = $null

  $ESC = [char]27

  $gitbranchView = if ($gitbranch)
  {

    if (-not $gitstatus)
    {
      $gitcolor = '{0}[37m' -f $ESC
    } elseif ($gitbranch -and ($gitstatus -match "(M|A|D|R|C) "))
    {
      $gitcolor = '{0}[93m' -f $ESC
    } elseif ($gitbranch -and ($gitstatus -match "\?\? "))
    {
      $gitcolor = '{0}[91m' -f $ESC
    } else
    {
      $gitcolor = '{0}[92m' -f $ESC
    }
    ' {0}[94m({1}{2}{3}[94m)' -f $ESC, $gitcolor, $gitbranch, $ESC
  } else
  {
    ''
  }
  '{0}[32m-> {1}[94m{2}{3}{4}[94m{5}[32m>{6}[37m ' -f $ESC, $ESC, $path, $gitbranchView, $ESC, $ESC, $ESC
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

#$git_location = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes"
#$profile_path = (Split-Path -Parent $PROFILE)

# $oh_my_posh_theme="easy-term.omp.json"
# $oh_my_posh_theme="tokyo.omp.json"
#$oh_my_posh_theme="tokyonight_storm.omp.json"

#if (-not (Test-Path $profile_path\$oh_my_posh_theme))
#{
#  Invoke-RestMethod -Uri $git_location\$oh_my_posh_theme -OutFile $profile_path\$oh_my_posh_theme
#}

#oh-my-posh --init --shell pwsh --config $profile_path\$oh_my_posh_theme | Invoke-Expression
# oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\$oh_my_posh_theme | Invoke-Expression
# oh-my-posh --init --shell pwsh | Invoke-Expression
#$modules = "Terminal-Icons"
Import-Module Terminal-Icons
#$modules | Import-Module
Remove-Alias ls 2>&1 | Out-Null
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
#
#fastfetch
