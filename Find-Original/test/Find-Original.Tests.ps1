$ModuleName = 'Find-Original'
$ModuleManifestName = "$ModuleName.psd1"
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

if (Get-Module $ModuleName) { Remove-Module $ModuleName }
Import-Module $ModuleManifestPath

Describe 'Unit Tests' {
    It 'finds uniquely named files' {
        $correct = (Get-Item "$PSScriptRoot\mockTarget\bar.txt").FullName
        if ($correct -isnot [array]) { $correct = [array]$correct }

        $result = (Find-UniqueFile -Source "$PSScriptRoot\mockSource" -Target "$PSScriptRoot\mockTarget").FullName
        if ($result -isnot [array]) { $result = [array]$result }

        $result | Should MatchArrayUnordered $correct
    }

    It 'finds uniquely sized files' {
        $correct = (Get-ChildItem "$PSScriptRoot\mockTarget")
        if ($correct -isnot [array]) { $correct = [array]$correct }

        $result = (Find-UniqueFile -Source "$PSScriptRoot\mockSource" -Target "$PSScriptRoot\mockTarget" -BySize)
        if ($result -isnot [array]) { $result = [array]$result }

        $result.FullName | Should MatchArrayUnordered $correct.FullName
    }
}
