# $env:PSModulePath = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\;C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement;C:\Program Files\WindowsPowerShell\Modules;C:\Users\jaiello\Documents\WindowsPowerShell\Modules"

function subl { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }
if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}

# Load posh-git example profile
. 'C:\tools\poshgit\dahlbyk-posh-git-7acc70b\profile.example.ps1'

Rename-Item Function:\Prompt PoshGitPrompt -Force
function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}

$env:NODE_PATH = Join-Path -Path $env:ProgramFiles -ChildPath 'nodejs\node_modules\'
New-Alias -name locate -value C:\Users\jaiello\AppData\Local\locate\Invoke-Locate.ps1 -scope Global -force
New-Alias -name updatedb -value C:\Users\jaiello\AppData\Local\locate\Update-LocateDB.ps1 -scope Global -force

# Load posh-git example profile
. 'C:\Users\jaiello\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

bash -c '/usr/games/fortune | /usr/games/cowsay -f tux'

$env:path += ';C:\OpenSSH-Win64'