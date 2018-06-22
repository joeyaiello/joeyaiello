# Make sure ssh-agent/add can be loaded by posh-git
# Set-Alias ssh-agent "$env:ProgramFiles\git\usr\bin\ssh-agent.exe"
# Set-Alias ssh-add "$env:ProgramFiles\git\usr\bin\ssh-add.exe"

if ($isWindows) {
    # Load posh-git example profile
    Import-Module posh-git

    # Create posh-git prompt
    function global:prompt {
        $realLASTEXITCODE = $LASTEXITCODE
        Write-Host($pwd.ProviderPath) -nonewline
        Write-VcsStatus
        $global:LASTEXITCODE = $realLASTEXITCODE
        return "> "
    }
}

if ($isWindows) {
	Add-WindowsPSModulePath
}

# touch
function touch { New-Item -Type File $args }

# s == start
New-Alias -Name s -Value start

# GNU-like which
function which($name) {
    Get-Command -Name $name | Select-Object -ExpandProperty Definition
}

# Add F5 key binding for PSReadline's CaptureScreen
if ($isWindows) { Set-PSReadlineKeyHandler -Function CaptureScreen -Chord Ctrl+[ }

# Use Windows-based PSReadline EditMode
Set-PSReadlineOption -EditMode Windows

# PSDefaultParameterValues
$PSDefaultParameterValues = @{
    "Install-Module:Scope"="CurrentUser"
}
