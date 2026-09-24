


Get-ChildItem truc -ErrorAction ignore
Get-ChildItem truc -ErrorAction SilentlyContinue

function Get-PSStream {
    [cmdletbinding()]
    param(

    )

    Write-Host 'terminal'
    Write-Output 'sortie standard'
    Write-Error 'argh'
    Write-Warning 'attention'
    Write-Verbose 'détail'
    Write-Debug 'Encore plus de détail'
    # le flux 6 information n'est pas un flux texte, collection d'objet InformationRecord
    Write-Information 'c''était vraiment intéressant'
}

Get-PSStream 
$res = Get-PSStream 
Get-PSStream -OutVariable res
Get-PSStream -ErrorAction Inquire -Verbose -Debug
Get-PSStream -ErrorAction stop -WarningAction stop
Get-PSStream -ea ignore -wa ignore
Get-PSStream -ea SilentlyContinue -ErrorVariable err -wa ignore

Get-PSStream -Verbose -Debug
Get-PSStream -Verbose -Debug -InformationAction Continue
Get-PSStream -Verbose -Debug -InformationAction SilentlyContinue -InformationVariable info



$ErrorActionPreference = 'stop'
# $WarningPreference, $VerbosePreference, $DebugPreference, $InformationPreference
Get-ChildItem bidule
Get-Process truc
Get-Service machin


# Commandes externes : Utilisation des redirections

nslookup toto.dawan.fr

nslookup toto.dawan.fr > $null            # sortie standard renvoyer dans $null
nslookup toto.dawan.fr > out.txt            # sortie standard renvoyer dans $null
nslookup toto.dawan.fr 1> $null 2> log.txt # Sortie d'erreur redirigée dans un fichier en écrasement
nslookup toto.dawan.fr > $null 2>> log.txt # Sortie d'erreur redirigée dans un fichier en ajout
nslookup www.dawan.fr *> $null           # Toutes les sorties sont redirigées
nslookup www.dawan.fr *> out.txt           # Toutes les sorties sont redirigées
nslookup www.dawan.fr *>> out.txt           # Toutes les sorties sont redirigées
nslookup www.dawan.fr 2>&1 >$null         # Sortie 2 redirigée dans la sortie 1 (sortie standard)
$out = nslookup www.dawan.fr 2>$null  


# Examen du code de sortie (de la dernière commande exécutée)
ping toto *> $null
if (-not $?) {  # $? : Exit Code booléen, $True si ok, $False si problème
    Throw 'Problème'
}

ping toto *> $null
$RC = $?
# ... un peu plus loin dans le script
if (-not $RC) {  # $? : Exit Code booléen, $True si ok, $False si problème
    Throw 'Problème'
}


ping server *> $null
if ($LASTEXITCODE -ne 0) { # Exit Code Entier (attention pas toujours instancié)
    Throw 'Problème'
}



# Erreur du .Net


Get-ADUser -Identity truc

try { # essayer d'exécuter les instructions du bloc try
    Get-ADUser -Identity truc
} 
catch { # $_ : erreur courante
    Add-Content -Path log.txt -Value $_.Exception.Message
}
finally { # nettoyage
    Write-Host 'Toujours exécuté'
}


try { # essayer d'exécuter les instructions du bloc try
    Get-ADUser -Identity truc
} catch { # le bloc est exécuté si erreur est rencontrée dans le bloc try
    Write-Host 'un pb a été recontré'
    $_ # erreur courante ou PSItem
}





try {
    New-ADOrganizationalUnit test -path 'cn=users,dc=formation,dc=lan'
    [Math]::Round(1/0)
    Get-ADUser -Identity truc
    [System.IO.File]::OpenRead('c:\test.txt')
} catch [System.IO.FileNotFoundException] {
    write-warning 'fichier pas trouvé'
} catch [Microsoft.ActiveDirectory.Management.ADException] {
    Write-Warning ('Erreur générale : ' + $_.Exception.Message)
} catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    Write-Warning ('Objet non trouvé : ' + $_.Exception.Message)
} catch {
    Write-Warning ('Autre erreur : ' + $_.Exception.Message)
    $_.Exception.GetType()
    $_.Exception.InnerException.GetType() 
}









