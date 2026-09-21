# Notes:
# https://hedgedoc.dawan.fr/s/HmiNJQFBs

# Github :
# https://github.com/dclement-dawan/powershell09-26
# https://github.com/dclement-dawan/powershell09-26.git

# OneDrive :
# https://dawaneducation-my.sharepoint.com/:f:/g/personal/dclement_dawan_education/IgC2Rt26Iab0SqmNwjtE-cnuAQGd7ulEcZnv3HaP2QcDCXc?e=0zvXuI


# ctrl + shift + p : preference

# Alias:
ls

# Commandes externes:
ping nas

# Cmdlets:
Get-ChildItem
Test-Connection nas

Get-Command *-process
Get-Command *-service
Get-Command *-localuser

# Commandes intégrées, builtin, primitives : if, switch, foreach, for, while, try...
if ($true) { 'Pause café ! :)' }


man stop-service -Online




# Les objets powershell

# Résultat formaté
Get-ChildItem
Get-Process
Get-Service

# Formatage du résultat
Get-ChildItem | Select *
Get-ChildItem | Select * | Out-GridView # présentation graphique
Get-ChildItem | Select * | ogv

Get-ChildItem | Select Name, *time
Get-ChildItem | Select-Object Name, *time
Get-ChildItem | fl Name, ext*, *name*
Get-ChildItem | Format-List Name, ext*, *name*
Get-ChildItem | ft ext*, *name*
Get-ChildItem | Format-Table Name, ext*, *name*
