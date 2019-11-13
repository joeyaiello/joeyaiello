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
cinst vscode --params ="'/NoDesktopIcon'"
cinst vscode-powershell
cinst microsoft-edge-insider-dev

## Module Installation

# Hold off on module installs until I figure out PS7
# Install-Module posh-git

# Temporarily turning off Windows feature enablement for remoting
<#
cinst Microsoft-Hyper-V-All -source windowsFeatures
Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
Enable-RemoteDesktop
#>