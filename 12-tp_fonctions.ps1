# 1- Créer une fonction Get-Min :
#  - en entrée :
#      $X obligatoire
#      $Y obligatoire
#  - en sortie
#     retourne le plus petit entre $X et $Y



# 2- Créer une fonction Get-Min2 :
#  - en entrée :
#      $X obligatoire de type int, compris entre -500 et 500
#      $Y obligatoire de type int, compris entre -500 et 500
#  - en sortie
#     retourne le plus petit entre $X et $Y

# [parameter(Mandatory)]
# [ValidateRange(-500,500)]
# [int]$x



# 3- Créer une fonction Get-TabEntier, saisie par l'utilisateur avec un Read-Host, -1 pour sortir de la saisie
# - en entrée : rien
# - en sortie : un tableau d'entiers

# tableau vide
$tab = @()
# ajouter dans le tableau
$tab += 15
# retour
return $tab


# 4- Créer une fonction Get-MinArray :
#  - en entrée :
#      $Tab un tableau d'entier [int[]] obligatoire avec 1 élément à minima
#  - en sortie
#     retourne le plus petit élément du tableau
