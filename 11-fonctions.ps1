# Pour renvoyer plusieurs résultats:
function Write-Hello {
    Write-Output 'Hello world !' # renvoie le résultat et continue le code de la fonction
    Write-Output 'Hello world !' # autre résultat
    Write-Host 'Fini' -BackgroundColor Red
}

# ou pour retourner un unique résultat
function Write-Hello2 {
    return 'Hello world !' # renvoie le résultat et met fin au code de la fonction
    Write-Host 'Jamais atteint' -BackgroundColor Red
}

Write-Hello
Write-Hello2



function Write-Hello3([string]$Nom, [string]$Prenom) {
    if (-not($Nom.Trim())) { throw 'Le nom est obligatoire' }
    return "Hello $Prenom $Nom !"
}

Write-Hello3 -Prenom Adèle


function Write-Hello4 {
    [CmdletBinding()]   # ajout des paramètres communs
    param(
        [ValidateLength(2, 35)] # longueur de la chaine entre 2 et 35 caract
        [ValidatePattern('^[a-zA-Z]+$')] # les caractères autorisés sont [a-z0-9]
        [parameter(Mandatory)]  # obligatoire
        [string]$Nom,           # typage

        [ValidateSet('Jules','Adèle','Maloù')] # valeurs autorisées
        [string]$Prenom = 'Jules',              # typage et valeur

        [ValidateSet('Mme', 'M', 'Dr', 'Pr')]
        [string]$Titre
    )
    return "Hello $Titre $Prenom $Nom !"
}


Write-Hello4 -Titre Dr -Prenom Jules -Nom 'C'
