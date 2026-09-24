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



