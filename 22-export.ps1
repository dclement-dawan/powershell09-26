Get-Process

Get-Process | Format-List -Property *


Get-Process > process.txt
Get-Process | Out-File process.txt -Encoding utf8
Get-Process | Export-Csv process.csv
Get-Process | Export-CliXml process.xml
Get-Process | ConvertTo-Json | Out-File process.json
Get-Process | ConvertTo-Html | Out-File process.html


# Propriété sous forme de script block
Get-ChildItem | Select-Object Name, {$_.Length / 1KB}

# Propriété sous forme de dictionnaire
Get-ChildItem | Select-Object Name, @{Name='SizeKB'; Expression={$_.Length / 1KB}}

# $_ ou $PSItem : objet courant

# Afficher le propriétaire du fichier :
#   cf Get-ACL
(Get-Acl -Path .\18-script.ps1).Owner

Get-ChildItem | Select-Object Name,
    @{Name='SizeKB'; Expression={$_.Length / 1KB}},
    @{Name='Owner'; Expression={ (Get-Acl $_).Owner }}


# Créer une fonction ConvertTo-HumanReadable
#     en entrée : un entier $Value obligatoire
#     en sortie :  un objet personnalisé powershell
#        avec les propriétés suivantes :
#          - taille avec l'unité [string]
#          - taille convertie sans l'unité [double]
#          - l'unité [string] : B, KB, MB, GB, TB, PB

1545879 / 1KB
1545879 / 1MB
1545879 / 1GB


function ConvertTo-HumanReadable {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [int]$Value
    )
    $temp = '[{"Unit":"KB", "value":"1024"},
    {"Unit":"MB", "value":"1048576"},
    {"Unit":"GB", "value":"1073741824"},
    {"Unit":"TB", "value":"1099511627776"},
    {"Unit":"PB", "value":"1125899906842624"}]'
    $tabUnit =  $temp | ConvertFrom-Json

    $resultTemp = $Value
    $unitTemp = 'B'
    foreach ($unite in $tabUnit) {
        if ($resultTemp / 1KB -lt 1) {
            break
        } else {
            $resultTemp /= 1KB
            $unitTemp = $unite.Unit
        }
    }

    return [PSCustomObject]@{
        SizeWithUnit = "${resultTemp}${unitTemp}"
        SizeWithUnitRounded = "$([int]$resultTemp)${unitTemp}"
        Size = $resultTemp
        Unit = $unitTemp
    }
}


# Afficher avec la taille du fichier en mode "human readable" :
Get-ChildItem -File |
    Select-Object Name,
        @{Name='SizeHR'; Expression={(ConvertTo-HumanReadable $_.Length).SizeWithUnitRounded}}


# Les utilisateurs sans adresse mail
Get-ADUser -Filter * -Properties * |
    Select-Object GivenName, Surname, SamAccountName, UserPrincipalName, EmailAddress, OfficePhone |
    Where-Object EmailAddress -eq $null | # 1 seule condition autorisée sans méthode
    Where-Object EmailAddress -notmatch '^[\t ]+$' |
    Export-Csv users.csv -Encoding utf8 -NoTypeInformation -Delimiter ';'


Get-ADUser -Filter * -Properties * |
    Select-Object GivenName, Surname, SamAccountName, UserPrincipalName, EmailAddress, OfficePhone |
    Where-Object {$_.EmailAddress -eq $null -or $_.EmailAddress.Trim() -eq ''} |
    Export-Csv users.csv -Encoding utf8 -NoTypeInformation -Delimiter ';'

Get-ADUser -Filter * -Properties * -SearchBase 'ou=admins,dc=dawan,dc=local' |
    Select-Object GivenName, Surname, SamAccountName, UserPrincipalName, EmailAddress, OfficePhone | # ?? : coalescing, si la valeur est nulle on prend la valeur après l'opérateur
    Where-Object {($_.EmailAddress ?? '').Trim() -eq ''} |
    Export-Csv users.csv -Encoding utf8 -NoTypeInformation -Delimiter ';'

# Méthode .Trim() sur les chaines : élagage, supprime les carac vides en début et fin de chaine
Get-ADUser -Filter * -Properties * -SearchBase 'ou=admins,dc=dawan,dc=local' |
    Select-Object GivenName, Surname, SamAccountName, UserPrincipalName, EmailAddress, OfficePhone |
    Where-Object {([string]($_.EmailAddress)).Trim() -eq ''} |
    Export-Csv users.csv -Encoding utf8 -NoTypeInformation -Delimiter ';'


    

Get-ADUser -Filter * -Properties * -SearchBase 'ou=admins,dc=dawan,dc=local' |
    Select-Object GivenName, Surname, SamAccountName, UserPrincipalName, EmailAddress, OfficePhone |
    Where-Object {([string]($_.EmailAddress)).Trim() -eq ''} |
    Sort-Object GivenName, Surname | # Tri ascendant par défaut
    Export-Csv users.csv -Encoding utf8 -NoTypeInformation -Delimiter ';'


Get-ChildItem |
    Select-Object Name, Length |
    Sort-Object Length -Descending |
    Select-Object -First 10


Get-ChildItem |
    Select-Object Name, LastWriteTime |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 10


Get-ADUser -Filter * -SearchBase 'ou=admins,dc=dawan,dc=local' |
    Set-ADUser -Department IT


Get-ADUser -Filter * -Properties Department |
    Group-Object Department

$dic = Get-ADUser -Filter * -Properties Department |
    Group-Object Department -AsHashTable

$dic['IT']
$dic.IT
$dic.'Admin local'
$dpt = 'Admin local'
$dic.$dpt


Get-ADUser -Filter * -Properties * | Measure-Object 

(Get-ADUser -Filter * -Properties * | Measure-Object).Count

# Calcul sur une propriété numérique
Get-ChildItem | Measure-Object Length -Sum -Average -Maximum -Minimum

# Powershell 7
Get-ChildItem | Measure-Object Length -StandardDeviation
Get-ChildItem | Measure-Object Length -AllStats
