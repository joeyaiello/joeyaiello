function Find-UniqueFile {

    [CmdletBinding()]
    param(
        # .PARAMETER Source
        # The source of truth
        [Parameter(Mandatory)]
        [System.String]
        $Source,

        # .PARAMETER Target
        # The target that contains duplicate and unique files
        [Parameter(Mandatory)]
        [System.String]
        $Target,

        # .PARAMETER Destination
        # An optional location to which the unique files will be copied.
        [Parameter()]
        [System.IO.Directory]
        $Destination,

        # .PARAMETER BySize
        # Size matters when comparing
        [Parameter()]
        [switch]
        $BySize,

        # .PARAMETER ByHash
        # Will use file hash values instead of filenames.
        # This will take considerably longer.
        [Parameter()]
        [switch]
        $ByHash
    )

    $SourceFiles = Get-ChildItem -Recurse $Source
    $TargetFiles = Get-ChildItem -Recurse $Target

    if ($ByHash) {
        $SourceHashes = Get-ChildItem -Recurse $SourceFiles | ? Attributes -ne 'Directory' | Get-FileHash
        $TargetHashes = Get-ChildItem -Recurse $TargetFiles | ? Attributes -ne 'Directory' | Get-FileHash

        $UniqueHashes = Compare-Object $SourceHashes $TargetHashes -Property Hash -PassThru | Where-Object SideIndicator -like '=>'
    }
    elseif ($BySize) {
        $UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -Property PSChildName,Length -PassThru | Where-Object SideIndicator -like '=>'
    }
    else {
#        $UniqueFilenames = (Compare-Object $SourceFiles.PSChildName $TargetFiles | ? SideIndicator -like '=>').InputObject
         $UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -Property PSChildName -PassThru | Where-Object SideIndicator -like '=>'
    }

    #$UnqiueFiles = foreach($i in $UniqueFilenames) {
    #    $UniqueFile = $TargetFiles | Where-Object PSChildName -like $i.PSChildName
    #}

    if ($ByHash) {
        $TargetFiles | Where-Object {(Split-Path -Leaf $UniqueHashes.Path).Contains($_.PSChildName)}
    }
    else {
        $TargetFiles | Where-Object {$UniqueFilenames.PSChildName.Contains($_.PSChildName)}
    }
}

Export-ModuleMember -Function Find-UniqueFile