function Invoke-Python3 {
	param(
		[Parameter(Mandatory=$false, Position=0)]
		[string]$Args,
		[Parameter(Mandatory=$false, ValueFromPipeline=$true)]
		[string]$InputObject,
		[switch]$NoConsole
	)
	
	$executable = if ($NoConsole) { 'pythonw.exe' } else { 'python.exe' }
	Write-Host $Args
	if ($InputObject) {
		$InputObject | & "$PSSCriptRoot\$executable" $Args
	} 
	else {
		& "$PSSCriptRoot\$executable" $Args
	}	
}


function Get-Python3EXE {
	param([switch]$NoConsole)
	$executable = if ($NoConsole) { 'pythonw.exe' } else { 'python.exe' }
	"$PSSCriptRoot\$executable"
}