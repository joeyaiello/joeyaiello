Login-AzureRmAccount

# Define the parameters for Get-AzureRmAutomationDscOnboardingMetaconfig using PowerShell Splatting
$Params = @{
    ResourceGroupName = 'jaaa'; # The name of the ARM Resource Group that contains your Azure Automation Account
    AutomationAccountName = 'jaaa-account'; # The name of the Azure Automation Account where you want a node on-boarded to
    ComputerName = @('localhost'); # The names of the computers that the meta configuration will be generated for
    OutputFolder = $PSScriptRoot;
}

# Use PowerShell splatting to pass parameters to the Azure Automation cmdlet being invoked
# For more info about splatting, run: Get-Help -Name about_Splatting
Get-AzureRmAutomationDscOnboardingMetaconfig @Params
$MetaConfigFolder = (Join-Path $Params.OutputFolder 'DscMetaConfigs')
Set-DscLocalConfigurationManager -Path $MetaConfigFolder
Remove-Item $MetaConfigFolder 