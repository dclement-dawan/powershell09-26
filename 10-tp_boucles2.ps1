# Reprendre le fichier 7-tp_bis.ps1 et ajouter une boucle do...while ou do...until autour du code existant pour permettre à l'utilisateur de répéter l'exécution du script jusqu'à ce qu'il choisisse de quitter.
# Ajouter un cas 5 pour sortir de la boucle et terminer le script.


Clear-Host
do {
    Write-Host "====================="
    Write-Host "1 - Créer un fichier"
    Write-Host "2 - Créer un dossier"
    Write-Host "3 - Afficher le contenu du dossier courant"
    Write-Host "4 - Afficher le contenu d'un fichier"
    Write-Host "5 - Sortir"
    $choix = Read-Host "Votre choix"
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
        5 {
            Write-Host 'Bye' -ForegroundColor Red
        }
        Default { Write-Warning "Mauvais choix. Choix valides 1 à 4, 5 pour sortir" }
    }
} until ($choix -eq 5)
# ou
# } while ($choix -ne 5)
