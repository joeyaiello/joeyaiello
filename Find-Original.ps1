function Find-UniqueFiles {

    [CmdletBinding()]
    param(
        # .PARAMETER Source
        # The source of truth 
        [Parameter(Mandatory)]
        [System.IO.File]
        $Source,

        # .PARAMETER Target
        # The target that contains duplicate and unique files 
        [Parameter(Mandatory)]
        [System.IO.File]
        $Target,

        # .PARAMETER Destination
        # An optional location to which the unique files will be copied. 
        [Parameter()]
        [System.IO.Directory]
        $Destination
    ) 

    $SourceFiles = Get-ChildItem -Recurse $Source
    $TargetFiles = Get-ChildItem -Recurse $TargetFiles

    $UniqueFilenames = (Compare-Object $SourceFiles.PSChildName $TargetFiles | ? SideIndicator -like '=>').InputObject
    
}