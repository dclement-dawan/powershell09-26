<# - Ajouter un test sur les cas 1 et 2 pour valider que le fichier ou le dossier n'existe pas.
s'il existe afficher un warning.

- Ajouter un test sur le cas 4 pour valider que le fichier existe.
s'il n'existe pas alors afficher un warning.

-not(Test-Path test)
Test-Path .\temp -PathType Leaf
#>
# $fichier= 'truc'
# Test-Path $fichier
# Test-Path temp -PathType Leaf

# -not(Test-Path temp)

Clear-Host
Write-Host "====================="
Write-Host "1 - Créer un fichier"
Write-Host "2 - Créer un dossier"
Write-Host "3 - Afficher le contenu du dossier courant"
Write-Host "4 - Afficher le contenu d'un fichier"
$choix = Read-Host "Votre choix de 1 à 4"
switch ($choix) {
    1 {
        $fichier = Read-Host "Fichier à créer"
        if (-not(Test-Path $fichier)) { # si le fichier n'existe pas alors
        # ou identique à:
        # if ((Test-Path $fichier) -eq $false) {
            New-Item $fichier
        } else {
            Write-Warning 'L''élément existe déjà'
        }
    }
    2 {
        $dossier = Read-Host "Dossier à créer"
        if ((Test-Path $dossier)) { # si le dossier existe déjà
        # identique à:
        # if ((Test-Path $dossier) -eq $true) {
            Write-Warning 'L''élément existe déjà'
        } else {
            New-Item $dossier -ItemType Directory
        }
    }
    3 { Get-ChildItem }
    4 {
        $fichier = Read-Host "Fichier à afficher"
        if (Test-Path $fichier -PathType Leaf) { # si le fichier existe alors
            Get-Content $fichier
        } else {
            Write-Warning "Le fichier $fichier n'existe pas"
        }
    }
    Default { Write-Warning "Mauvais choix. Choix valides 1 à 4" }
}
