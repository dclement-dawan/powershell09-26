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
Get-ChildItem |
    Select-Object Name,
        @{Name='SizeHR'; Expression={(ConvertTo-HumanReadable $_.Length).SizeWithUnitRounded}}
