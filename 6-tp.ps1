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
