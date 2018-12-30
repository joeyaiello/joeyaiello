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
        $result = (Find-UniqueFile -Source "$PSScriptRoot\mockSource" -Target "$PSScriptRoot\mockTarget").FullName

        ($result -Join ":") | Should Be ($correct -Join ":")
    }

    It 'finds uniquely sized files' {
        $correct = (Get-ChildItem "$PSScriptRoot\mockTarget" | sort-object name).FullName
        $result = (Find-UniqueFile -Source "$PSScriptRoot\mockSource" -Target "$PSScriptRoot\mockTarget" -BySize | sort-object name).FullName

        ($result -Join ":") | Should BeExactly ($correct -Join ":")
    }

    It 'find uniquely hashed, same-sized files' {
        $correct = (Get-ChildItem "$PSScriptRoot\mockHashTarget\sameSize.txt").FullName
        $result = (Find-UniqueFile -Source "$PSScriptRoot\mockHashSource" -Target "$PSScriptRoot\mockHashTarget" -ByHash).FullName

        ($result -Join ":") | Should BeExactly ($correct -Join ":")
    }
}
