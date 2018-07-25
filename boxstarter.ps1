Enable-MicrosoftUpdate
# I think I want Install-WindowsUpdate *first*, but I'm not sure yet
# Install-WindowsUpdate
# Also, why not use built-in WindowsUpdateProvider?

Disable-BingSearch
Disable-InternetExplorerESC
# Figure out Move-LibraryDirectory and Get-LibraryNames
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -DisableOpenFileExplorerToQuickAccess -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess -EnableShowRibbon
Set-TaskbarOptions -Size Small -UnLock -Dock Bottom -Combine Never
Enable-RemoteDesktop
Update-ExecutionPolicy -policy Bypass

cinst git --params="'/GitOnlyOnPath /NoShellIntegration /SChannel'"
cinst vscode --params ="'/NoDesktopIcon'"
cinst vscode-powershell
Install-Module posh-git

cinst Microsoft-Hyper-V-All -source windowsFeatures
Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
