function Write-Documentation {
    <#
    .SYNOPSIS
        Doit être le premier commentaire du script ou de la fonction
        Documentation du script/fonction
    .DESCRIPTION
        ... description longue
    .LINK
        https://github.com/dclement-dawan/powershell09-26
    .EXAMPLE
        ...
    .EXAMPLE
        ...
    .PARAMETER PARAM1
        ...
    .PARAMETER PARAM2
        ...
    .INPUTS
       ... les entrées de la fonction/script
    .OUTPUTS
       ... les sorties
    .NOTES
      infos complémentaires
      snippet comment-help
    #>
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$param1,
        [switch]$param2
    )
}


Get-help Write-Documentation
Get-help Write-Documentation -ShowWindow
Get-help Write-Documentation -Online
Get-help Write-Documentation -Examples
