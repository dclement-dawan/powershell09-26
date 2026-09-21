<# TP
Demander à  l'utilisateur un choix entre 1 et 4. (Read-Host)

En fonction du choix : (switch)
    - 1 : demander un nom de fichier (Read-host) et
    le créer dans le dossier courant (New-Item)

    - 2 : demander un nom de dossier (Read-host) et
    le créer dans le dossier courant (New-Item)

    - 3 : afficher la liste des fichiers/dossiers de
    l'emplacement courant (Get-ChildItem)

    - 4 : demander un nom de fichier (Read-Host) et
    afficher son contenu (Get-Content)

    - autre choix : afficher un avertissement 'Mauvais choix'
    (Write-Warning)
#>
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
        New-Item $fichier
    }
    2 {
        $dossier = Read-Host "Dossier à créer"
        New-Item $dossier -ItemType Directory
    }
    3 { Get-ChildItem }
    4 {
        $fichier = Read-Host "Fichier à afficher"
        Get-Content $fichier
    }
    Default { Write-Warning "Mauvais choix. Choix valides 1 à 4" }
}
