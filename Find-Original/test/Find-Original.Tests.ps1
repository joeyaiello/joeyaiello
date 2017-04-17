$ModuleManifestName = 'Find-Original.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Import-Module $ModuleManifestPath

Describe 'Unit Tests' {
    It 'finds uniquely named files' {
        $correct = Get-Item "$PSScriptRoot\mockTarget\bar.txt"
        $result = Find-UniqueFile -Source "$PSScriptRoot\mockSource" -Target "$PSScriptRoot\mockTarget"
        $result | Should Be $correct
    }
}
