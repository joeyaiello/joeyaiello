function GetLengthDifferenceFromMatchingFilenames {
    param(
        [Parameter(Mandatory)]
        [System.Object[]]
        $a,
        [Parameter(Mandatory)]
        [System.Object[]]
        $b
    )

    $output = New-Object System.Collections.ArrayList

    foreach ($i in $b) {
        foreach ($j in $a) {
            if (($i.Name -eq $j.Name) -and ($i.Length -ne $j.Length)) {
                $output.Add([pscustomobject]@{
                    Name = $i.Name
                    SourceLength = $j.Length
                    TargetLength = $i.Length
                    LengthDifference = ($j.Length)-($i.Length)
               }) | Out-Null
            }
        }
    }

    return $output
}

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
        [System.String]
        [ValidateSet('Larger','Smaller','Both')]
        $BySize
    )

    $SourceFiles = Get-ChildItem -Recurse $Source
    $TargetFiles = Get-ChildItem -Recurse $Target

    if ($BySize -like 'Both') {
        #$UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -Property PSChildName,Length -PassThru
        GetLengthDifferenceFromMatchingFilenames -a $SourceFiles -b $TargetFiles
    }
    elseif ($BySize -like 'Larger') {
        $UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -Property PSChildName,Length -PassThru #| Where-Object SideIndicator -like '=>'
        1
    }
    else {
        #$UniqueFilenames = (Compare-Object $SourceFiles.PSChildName $TargetFiles | ? SideIndicator -like '=>').InputObject
        $UniqueFilenames = Compare-Object $SourceFiles $TargetFiles -Property PSChildName -PassThru | Where-Object SideIndicator -like '=>'
        $TargetFiles | Where-Object {$UniqueFilenames.PSChildName.Contains($_.PSChildName)}
    }

    #$UnqiueFiles = foreach($i in $UniqueFilenames) {
    #    $UniqueFile = $TargetFiles | Where-Object PSChildName -like $i.PSChildName
    #}

}



Export-ModuleMember -Function Find-UniqueFile