
# Ordinateur : win11.david-clement.eu
# login :  dawan\prenom
# mot de passe : F0rmation! 



Get-Help new-aduser -Examples

New-ADUser `
    -Name 'David Clément' `
    -GivenName 'David' `
    -Surname 'Clément' `
    -DisplayName 'David Clément' `
    -Initials 'DCL' `
    -SamAccountName 'david.clement' `
    -UserPrincipalName 'david.clement@dawan.local' `
    -Description "Créé via Powershell le $(Get-Date)" `
    -AccountPassword (Read-Host 'Mot de passe' -AsSecureString) `
    -Enabled $true `
    -ChangePasswordAtLogon $true `
    -Path 'ou=david,dc=dawan,dc=local'


$pswd = ConvertTo-SecureString 'F0rmation!' -Force -AsPlainText
$pswd | ConvertFrom-SecureString


function Get-Password {
    $tabMaj = 'AZERTYUIOPQSDFGHJKLMWXCVBN' -split '' | Select-String -NotMatch '^$'
    $tabMin = 'azertyuiopqsdfghjklmwxcvbn' -split '' | Select-String -NotMatch '^$'
    $tabChiffre = '0123456789' -split '' | Select-String -NotMatch '^$'

    $tab= @()
    $tab += $tabMaj | Get-Random -Count 3
    $tab += $tabMin | Get-Random -Count 3
    $tab += $tabChiffre | Get-Random -Count 3

    $tab = $tab | Sort-Object {Get-Random}

    return $tab -join ''
}

# importation de fichier csv:

Import-Csv .\import.csv

Import-Csv .\import.csv -UseCulture
Import-Csv .\import.csv -Delimiter ';' -Encoding utf8
Import-Csv .\import.csv -Delimiter ';' -Encoding utf8 -Header 'col1','col2','col3'



# Adapter le code de création du compte utilisateur
# pour chaque utilisateur renvoyer le login SamAccountName et le mot de passe

$tabUsers = Import-Csv .\import.csv -Delimiter ';' -Encoding utf8
$nb = $tabUsers.Count
$i = 1
foreach ($user in $tabUsers) {
    $Password = Get-Password
    $Name = $user.prenom+' '+$user.nom
    $Initiales = ($user.prenom.Substring(0, 1)+$user.nom.Substring(0, 2)).ToUpper()
    $SamAccountName = ($user.prenom+'.'+$user.nom).ToLower()
    $UserPrincipalName = $SamAccountName + '@dawan.local'
    Write-Progress -Activity 'Création de comptes' `
        -Status "Utilisateur $Name ($i/$nb)" `
        -PercentComplete ([int]($i / $nb * 100))
    Start-Sleep -seconds 1

    New-ADUser `
        -Name $Name `
        -GivenName $user.prenom `
        -Surname $user.nom `
        -DisplayName $Name `
        -Initials $Initiales `
        -SamAccountName $SamAccountName `
        -UserPrincipalName $UserPrincipalName `
        -Description "Créé via Powershell le $(Get-Date)" `
        -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
        -Enabled $true `
        -ChangePasswordAtLogon $true `
        -Path 'ou=david,dc=dawan,dc=local' # -WhatIf
    
    Write-Output ([PSCustomObject]@{
        Login = $SamAccountName
        Password = $Password
    })
    $i++
}
# Bonus : Ajouter une barre de progression
