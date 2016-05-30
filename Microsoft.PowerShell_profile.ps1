function subl { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }

# Make sure ssh-agent/add can be loaded by posh-git
Set-Alias ssh-agent "$env:ProgramFiles\git\usr\bin\ssh-agent.exe"
Set-Alias ssh-add "$env:ProgramFiles\git\usr\bin\ssh-add.exe"

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

# Load Invoke-Locate
New-Alias -name locate -value C:\Users\jaiello\AppData\Local\locate\Invoke-Locate.ps1 -scope Global -force
New-Alias -name updatedb -value C:\Users\jaiello\AppData\Local\locate\Update-LocateDB.ps1 -scope Global -force

# touch
function touch { New-Item -Type File $args }

# s == start
New-Alias -Name s -Value start

# All last minute PATH additions 
$env:path += ';C:\OpenSSH-Win64'
$env:path += ";${env:SystemRoot}\Microsoft.Net\Framework\v4.0.30319"

# Add F5 key binding for PSReadline's CaptureScreen
Set-PSReadlineKeyHandler -Function CaptureScreen -Chord Ctrl+[

