Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
Enable-RemoteDesktop

cinst git --params="'/GitOnlyOnPath /NoShellIntegration /SChannel'"
cinst vscode --params ="'/NoDesktopIcon'"
cinst vscode-powershell
Install-Module posh-git

cinst Microsoft-Hyper-V-All -source windowsFeatures
Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
