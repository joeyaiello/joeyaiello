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
        $BySize
    )

    $SourceFiles = Get-ChildItem -Recurse $Source
    $TargetFiles = Get-ChildItem -Recurse $Target

    if ($BySize) {
        $UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -Property PSChildName,Length -PassThru | Where-Object SideIndicator -like '=>'
    }
    else {
#        $UniqueFilenames = (Compare-Object $SourceFiles.PSChildName $TargetFiles | ? SideIndicator -like '=>').InputObject
         $UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -PassThru | Where-Object SideIndicator -like '=>'
    }

    #$UnqiueFiles = foreach($i in $UniqueFilenames) {
    #    $UniqueFile = $TargetFiles | Where-Object PSChildName -like $i.PSChildName
    #}

    $TargetFiles | Where-Object {$UniqueFilenames.PSChildName.Contains($_.PSChildName)}
}

Export-ModuleMember -Function Find-UniqueFile