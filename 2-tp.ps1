# F8 : Exécution de la ligne courante ou de la sélection
# F5 : exéc du script en mode débug

# 1- Démarrer le process Notepad et le terminer
# Avec son nom puis son PID

Get-Command *-process
Get-Help start-process -Examples

notepad.exe
# ou
Start-Process -FilePath notepad
Start-Process notepad
Start-Process -FilePath notepad -Wait
# ou
Invoke-Command -ScriptBlock { notepad }


help stop-process -online
# Arrêt avec le PID
Get-Process -Name Notepad
Get-Process Notepad

Stop-Process -Id 32456
Stop-Process 32456

# Arrêt avec le nom
Stop-Process -Name Notepad



# 2- Créer un dossier "temp" dans l'emplacement courant

Get-Command *-item
Get-Help New-Item -ShowWindow

New-Item -Name temp -ItemType Directory
# ou
New-Item -Path (Get-Location) -Name temp -ItemType Directory
# ou
mkdir temp




# 3- Créer un fichier test.pdf dans le dossier temp
New-Item temp\test.pdf
# ou
New-Item -Path temp -Name test.pdf -ItemType File

# 4- Afficher les fichiers avec leur nom et extension

Get-ChildItem -Recurse -File

Get-ChildItem -Recurse -File | fl *

Get-ChildItem -Recurse -File | Select-Object Name, Extension
Get-ChildItem -Recurse -File | Format-List Name, Extension
Get-ChildItem -Recurse -File | Format-Table Name, Extension

# 5- Afficher les fichiers avec leur nom et les dates associées

Get-ChildItem -Recurse -File | Select-Object Name, *time
# ou
Get-ChildItem -Recurse -File | Select-Object Name, CreationTime, LastWriteTime, LastAccessTime
