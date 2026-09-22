# Créer un module CustomModule2 dans ~\documents\Powershell\modules

# New-Item CustomModule2 -Force -ItemType Directory
# New-ModuleManifest -Path .\CustomModule2\CustomModule2.psd1 `
#     -RootModule CustomModule2.psm1 -ModuleVersion 1.0.0


# Créer une fonction dans ce module Get-Manufacturer2

# Modifier la v1 de la fonction Get-Manufacturer
# Au début de la fonction :


# Ajouter un paramètre de type [Switch]$DownloadOUI

# Si $DownloadOUI est vrai , alors supprimer le fichier oui.txt

#  Si le fichier oui.txt a plus 15 jours alors le supprimer
#     (Get-Item ./oui.txt).CreationTime

#  Vérifier la présence du fichier oui.txt (Test-Path), s'il n'existe pas le télécharger
#    Invoke-WebRequest
# https://standards-oui.ieee.org/  -> oui.txt

# Modifier la date pour le test:
(Get-Item .\oui.txt).CreationTime = '01/01/2026'

(Get-Item .\oui.txt).CreationTime

# Tester les dates :
((Get-Date) -  (Get-Item .\oui.txt).CreationTime ).TotalDays -gt 15

(Get-Item .\oui.txt).CreationTime -lt (Get-Date).AddDays(-15)
