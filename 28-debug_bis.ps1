<#
.SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
#Requires -Module ActiveDirectory

[CmdletBinding(SupportsShouldProcess)]  # active le dry-run pour les cmdlets concernées
param()

trap {  # gestionnaire générique, rattrape toutes les erreurs
    Write-Host 'Gestionnaire global'
    Add-Content -Value "$(Get-Date); $($Error[0].Exception.Message)" -Path log.txt
    exit 1
}
trap [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    Write-Host 'Gestionnaire particulier'
    Add-Content -Value "$(Get-Date); $($Error[0].Exception.Message)" -Path log.txt
    exit 2
}
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest  # interdit les variables non initialisées et les propriétés inexistantes


if ($PSCmdlet.ShouldProcess('Executable', 'Ecrire dans le terminal')) {
    Write-Host 'appel à des exe ...' # la commande est exécutée si -whatif n'est pas spécifié
}


New-ADOrganizationalUnit test -path 'cn=users,dc=formation,dc=lan'

Get-ADUser -Identity truc



