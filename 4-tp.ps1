# TP

# Demander un nom, une extension et un contenu (Read-Host, à stocker dans des variables).
# Créer le fichier $nom.$extension contenant le contenu souhaité (New-Item)

$Nom = Read-Host 'Nom de fichier'
$Extension = Read-Host 'Extension de fichier'
$Contenu = Read-Host 'Contenu du fichier'

New-Item -Name "${Nom}.${Extension}" -Value $Contenu

# - Demander un nom de clé de registre et la créer dans hkcu:\Software  (New-Item)
# - Demander un nom de propriété et une valeur, puis la créer dans la clé précédemment créée (New-ItemProperty)

$Cle = Read-Host 'Nom de Clé'
$Propriete = Read-Host 'Propriété'
$Valeur = Read-Host 'Valeur'

New-Item -Path HKCU:\Software -Name $Cle

New-ItemProperty -Path HKCU:\Software\$Cle -Name $Propriete -Value $Valeur -PropertyType String
