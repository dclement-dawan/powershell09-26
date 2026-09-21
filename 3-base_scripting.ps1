
ls



Get-ADUser -Filter "GivenName -ne '' -and SurName -ne ''" -Properties EmailAddress | Where-Object GivenName -ne '' | Select-Object Name, GivenName, SurName, UserPrincipalName, SamAccountName, EmailAddress

# devient :
Get-ADUser `
    -Filter "GivenName -ne '' -and
    SurName -ne ''" `
    -Properties EmailAddress |
    Where-Object EmailAddress -ne '' |
    Select-Object Name, GivenName, SurName,
    UserPrincipalName, SamAccountName, EmailAddress



"`t fsdfsdf `n sdfsdfs"


# Variables :

Get-Variable

$var = 'toto'

New-Variable -Name var2 -Value 'tutu'
New-Variable -Name var3 -Value 'tutu' -Visibility Private
New-Variable -Name const1 -Value 'tutu' -Option Constant


$x = 1
$i = '1'
$b = $true
$c1 = "chaine dynam${i}que $x $(Get-Date)" # avec interpolation
$c2 = 'chaine statique $x'  # sans interpolation


Write-Host $c1     # affichage de présentation
Write-Output $c1   # retourne un résultat, sortie standard
$c2   # idem Write-Output


$res = Write-Host $c1     # affichage de présentation
$res = Write-Output $c1   # retourne un résultat, sortie standard


$saisie = Read-Host 'Invite de saisie'
Write-Output "Vous avez saisi : $saisie"

$fichier = Read-Host 'fichier'
New-Item $fichier

# Structure d'un objet
$fichier | Get-Member
$fichier | gm
$fichier.Length
$fichier.Split('.')
$fichier.Substring(0, 3)


# Tableau
$tab = @()  # tableau vide
$tab = 1,2,3,4,5
$tab = @(1,2,3,4,5)
$tab3 = 1,"2",$true,$null,5.154
$tab2 = @(1,2,3,4,5), @(6,7,8,9,10)

$tab.Count
$tab[0] # premier élément
$tab[-1] # dernier élément
# ajout en fin de tableau
$tab += 6
$tab = $tab + 6
$tab

$tab2[0][3]

# Liste
$liste = New-Object System.Collections.ArrayList
$liste.AddRange($tab)
$liste

$liste.Add(7)
$liste.Insert(6, 7)
$liste.Remove(2)
$liste.RemoveAt(3)

# Dictionnaire, hashtable, tableau associatif : clé -> valeur

$dict = @{nom = 'Clément'; prénom = 'David'; age=49}

$dict['age']
$dict.nom
$dict.prénom

$dict += @{ville = "Poitiers"}
$dict

# Objet personnalisé Powershell : PSCustomObject

$obj = [PSCustomObject]@{
    Name = 'Value'
}

$obj = [PSCustomObject]@{nom = 'Clément'; prénom = 'David'; age=49}

$obj.prénom

# ajout d'une propriété
$obj | Add-Member -MemberType NoteProperty -Name Ville -Value Poitiers





$tab = @()
$tab += [PSCustomObject]@{nom = 'Clément'; prénom = 'David'; age=49}
$tab += [PSCustomObject]@{nom = 'Clément'; prénom = 'Jules'; age=13}
$tab += [PSCustomObject]@{nom = 'Clément'; prénom = 'Malo'; age=16}
$tab += [PSCustomObject]@{nom = 'Clément'; prénom = 'Adèle'; age=10}

$tab | Where-Object age -lt 20 | Select-Object Prénom | Sort-Object prénom | Out-GridView
