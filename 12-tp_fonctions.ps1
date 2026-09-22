# 1- Créer une fonction Get-Min :
#  - en entrée :
#      $X obligatoire
#      $Y obligatoire
#  - en sortie
#     retourne le plus petit entre $X et $Y

function Get-Min {
    param (
        [Parameter(Mandatory)]
        $X,

        [Parameter(Mandatory)]
        $Y
    )
    if ($X -lt $Y) {
        return $X
    }
    return $Y
}

Get-Min -X 1 -Y -10
Get-Min 1 10

# 2- Créer une fonction Get-Min2 :
#  - en entrée :
#      $X obligatoire de type int, compris entre -500 et 500
#      $Y obligatoire de type int, compris entre -500 et 500
#  - en sortie
#     retourne le plus petit entre $X et $Y

# [parameter(Mandatory)]
# [ValidateRange(-500,500)]
# [int]$x

function Get-Min2 {
    param (
        [ValidateRange(-500, 500)]
        [Parameter(Mandatory)]
        [int]$X,

        [ValidateRange(-500, 500)]
        [Parameter(Mandatory)]
        [int]$Y
    )
    if ($X -lt $Y) {
        return $X
    }
    return $Y
}

Get-Min2 -X 500 -Y -200

# 3- Créer une fonction Get-TabEntier, saisie par l'utilisateur avec un Read-Host, -1 pour sortir de la saisie
# - en entrée : rien
# - en sortie : un tableau d'entiers


function Get-TabEntier {
    [CmdletBinding()]param ()
    # tableau vide
    [int[]]$tab = @()
    do {
        [int]$saisie = Read-Host 'Un entier positif, -1 pour sortir'
        if ($saisie -ge 0) {
            # ajouter dans le tableau
            $tab += $saisie
        }
    } until ($saisie -eq -1)
    return $tab
}

Get-TabEntier







# 4- Créer une fonction Get-MinArray :
#  - en entrée :
#      $Tab un tableau d'entier [int[]] obligatoire avec 1 élément à minima
#  - en sortie
#     retourne le plus petit élément du tableau



function Get-MinArray {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateScript({$_.Count -ge 1})]
        [int[]]$Tab
    )
    $PetitTemp = $Tab[0]
    foreach ($item in $Tab) {
        $PetitTemp = Get-Min $PetitTemp $item
    }
    return $PetitTemp
}

Get-MinArray 1,2,3,-1,4,5,6


function Get-MinArray2 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateScript({$_.Count -ge 1})]
        [int[]]$Tab
    )
    return ($Tab | Measure-Object -Minimum).Minimum
}

Get-MinArray2 1,2,3,-1,4,5,6
