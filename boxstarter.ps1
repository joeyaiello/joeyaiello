Enable-MicrosoftUpdate
# I think I want Install-WindowsUpdate *first*, but I'm not sure yet
# Install-WindowsUpdate
# TODO: why not use built-in WindowsUpdateProvider?

Disable-BingSearch
Disable-InternetExplorerESC
# TODO: Figure out Move-LibraryDirectory and Get-LibraryNames
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles `
                           -EnableShowFileExtensions -DisableOpenFileExplorerToQuickAccess `
                           -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess `
                           -EnableShowRibbon
Set-TaskbarOptions -Size Small -UnLock -Dock Bottom -Combine Never
Update-ExecutionPolicy -policy Bypass

cinst git --params="'/GitOnlyOnPath /NoShellIntegration /SChannel'"

### VS code
cinst vscode --params ="'/NoDesktopIcon'"
# TODO: replace this with an eventual code invocation that gets the preview extension
cinst vscode-powershell

### Chromium Edge Dev
cinst microsoft-edge-insider-dev
# TODO: how do I install extensions?
# TODO: is it enough to login with MSA in Win10 to get non-extensions?

## Module Installation

# Hold off on module installs until I figure out PS7
# Install-Module posh-git

# Temporarily turning off Windows feature enablement for remoting
<#
cinst Microsoft-Hyper-V-All -source windowsFeatures
Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
Enable-RemoteDesktop
#>