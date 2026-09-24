# Mettre à jour les champs Department et Organization des comptes de votre OU
# Utiliser la technique du parameter splatting


# 1- Extraire les données au format JSON
Get-ADUser -Filter * -SearchBase 'ou=david,dc=dawan,dc=local' -Properties Department, Organization |
    Select-Object SamAccountName, Department, Organization |
    ConvertTo-Json | 
    Out-File maj.json -Encoding utf8 


# 2- Mettre à jour le fichier
# cf maj.json

# 3- Importer et traiter le fichier modifié
$VerbosePreference = 'Continue'
$tabUsers = Get-Content .\maj.json | ConvertFrom-Json 
foreach ($user in $tabUsers) {
    $params = @{
        Identity = $user.SamAccountName
        Department = ($user.Department.Length -gt 20) ? $user.Department.Substring(0, 20) : $user.Department
        Organization = $user.Organization
    }
    # if ($params.Department.Length -gt 20) {$params.Department.Substring(0, 20)}
    Write-Verbose "Paramètres transmis : $($params | Out-String)"
    Set-ADUser @params # -Whatif
}

# Pour le powershell 7
# opérateur ternaire :  condition ? valeur si vraie : valeur si fausse
$c='01234567890123456789012345'
$c.length -gt 25 ? $c.Substring(0.20) : $c
