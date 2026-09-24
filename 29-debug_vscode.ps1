[cmdletbinding()]param()

trap {  # gestionnaire générique, rattrape toutes les erreurs
    Write-Host 'Gestionnaire global'
    Add-Content -Value "$(Get-Date); $($_ | Out-String)" -Path log.txt
    exit 1
}

. $PSScriptRoot\lib\librairie.ps1

for ($i = 0; $i -lt 1000; $i++) {
    foobar $i
    Write-Verbose $i
    if ($i -eq 998) {
        throw 'argh'
    }
}