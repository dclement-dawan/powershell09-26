# Créer un module CustomModule2 dans ~\documents\Powershell\modules

# New-Item CustomModule2 -Force -ItemType Directory
# New-ModuleManifest -Path .\CustomModule2\CustomModule2.psd1 `
#     -RootModule CustomModule2.psm1 -ModuleVersion 1.0.0


# Créer une fonction dans ce module Get-Manufacturer2

# Au début de la fonction :

#  Vérifier la présence du fichier oui.txt (Test-Path), s'il n'existe pas le télécharger
#    Invoke-WebRequest
# https://standards-oui.ieee.org/  -> oui.txt


#  Si le fichier oui.txt a plus 15 jours, le re-télécharger.
#     (Get-Item ./oui.txt).CreationTime


# Ajouter un paramètre de type [Switch] $DownloadOUI
# Si $DownloadOUI est vrai , alors re-télécharger le fichier.



# Modifier la date pour le test:
(Get-Item ./oui.txt).CreationTime = '01/01/2026'

(Get-Item ./oui.txt).CreationTime

((Get-Date) -  (Get-Item ./oui.txt).CreationTime ).TotalDays -gt 15

(Get-Item ./oui.txt).CreationTime -lt (Get-Date).AddDays(-15)
