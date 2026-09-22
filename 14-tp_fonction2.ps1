# https://standards-oui.ieee.org/

# Créer une fonction Get-Manufacturer
#    en entrée: une adresse MAC $MACAddress de type String obligatoire
#    utiliser un [ValidatePattern('^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$')] sur le paramètre $MacAddress
'C4-E9-0A-96-B1-C3' -match '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$'
'C4:E9:0A:96:B1:C3' -match '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$'
'C4E90G96B1C3' -match '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$'

#   en sortie: le nom du fabricant ou 'N/A' si inexistant
# Documenter la fonction

# But : A partir du fichier oui.txt récupérer le nom du fabricant


# ipconfig /all   ou  Get-NetAdapter
# 'C4-E9-0A-96-BC-CF'
# 'C4-E9:0A 96-BC-CF' -replace '-',''
# Nettoyer l'adresse MAC

'C4-E9:0A 96-BC-CF' -replace '-|:| ', '' # avec expression régulière (| = ou logique)

# Découper l'adresse MAC et récupérer le préfixe de 3 octets
'C4E90A96BCCF'.Substring(0, 6)  # 3 premiers octets

# Chercher le préfixe d'adresse mac dans le fichier oui.txt
# Convertir un objet en chaine de caractères
Select-String -Pattern 'C4E90A' -Path .\oui.txt -SimpleMatch | Out-String
# ou
(Select-String -Pattern 'C4E90A' -Path .\oui.txt -SimpleMatch)[0].Line

# -split : opérateur de découpage string -> array
# découpage de la chaîne avec le caractère tabulation `t
# le deuxième élément
('C4E90A     (base 16)		D-Link International' -split "`t+")[1]

# ou $tab[-1] : dernier élément du tableau
('C4E90A     (base 16)		D-Link International' -split "`t+")[-1]



# première étape: chaîner les commandes avec des variables intermédiaires

$MacAddress = '00-50-56-C0-0F-12'
$CleanMacAddress = $MacAddress -replace '-|:| ', ''
$MacPrefix = $CleanMacAddress.Substring(0, 6)
$Line = Select-String -Pattern $MacPrefix -Path .\oui.txt -SimpleMatch | Out-String
if ($line) {
    $Manufacturer = ($Line -split "`t+")[1]
} else {
    $Manufacturer = 'N/A'
}

Write-Output $Manufacturer

# deuxième étape : intégrer ses commandes dans la fonction
# avec le paramètre et la doc


function Get-Manufacturer {
<#
.SYNOPSIS
    Récupère le nom du fabricant d'un équipement réseau en fonction de l'adresse MAC
.LINK
        https://github.com/dclement-dawan/powershell09-26
.PARAMETER MacAddress
    Une adresse MAC valide 12 chiffres hexadécimaux en majuscule ou minuscule avec séparateur ':', '-', ' ' ou sans séparateur.
.EXAMPLE
    PS C:\>Get-Manufacturer -MacAddress '00-50-56-C0-0F-12'
    VMware, Inc.
.EXAMPLE
    PS C:\>Get-Manufacturer 'C4:E9:0A:96:B1:C3'
    D-Link International
#>
    [CmdletBinding()]
    param (
        [ValidateScript({if ($_ -NotMatch '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$') {throw "Format d'adresse MAC invalide"} else {$true} })]
        # [ValidatePattern('^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$')]
        [Parameter(Mandatory)]
        [String]$MacAddress
    )
    Write-Verbose "Adresse MAC reçue: $MacAddress"
    # $MacAddress = '00-50-56-C0-0F-12'
    $CleanMacAddress = $MacAddress -replace '-|:| ', ''
    Write-Verbose "Adresse MAC nettoyée: $CleanMacAddress"
    $MacPrefix = $CleanMacAddress.Substring(0, 6)
    Write-Verbose "Préfixe d'adresse MAC: $MacPrefix"
    $Line = Select-String -Pattern $MacPrefix -Path .\oui.txt -SimpleMatch | Out-String
    Write-Verbose "Résultat de la recherche dans le fichier: $Line"
    if ($line) {
        $Manufacturer = ($Line -split "`t+")[1]
    } else {
        $Manufacturer = 'N/A'
    }
    Write-Debug "Constructeur trouvé : $Manufacturer"
    return $Manufacturer
}

Get-Manufacturer -MacAddress '00-50-56-C0-0F-12' -Verbose
Get-Manufacturer -MacAddress '00-50-56-C0-0F-12' -Verbose -Debug
Get-Manufacturer -MacAddress '00-50-56-C0-0F-12'
Get-Manufacturer 'C4:E9:0A:96:B1:C3'

Get-Help Get-Manufacturer -ShowWindow
Get-Help Get-Manufacturer -Examples


Get-NetAdapter |
    Where MacAddress -NotMatch '--' |
    Foreach { Get-Manufacturer $_.MacAddress }
