# Q1: Créer 200 fichiers nommés 1.log à 200.log dans un dossier nommé "temporaire"






# Q2: Suite à une erreur, on va renommer les fichiers ainsi :
#    1.log devient  0001.log
#           ...
#  200.log devient  0200.log


'1.log'.PadLeft(8, '0')
'200.log'.PadLeft(8, '0')

# exécution en dry-run
Rename-Item -Path 1-intro.ps1 -NewName test.ps1 -WhatIf
