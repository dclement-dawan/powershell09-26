# Credential et Powershell remoting



# WinRM : Windows Remote Management (HTTP TCP/5985 ou HTTPs TCP/5986)

# ouverture de session interactive
# pas possible de l'intégrer dans un script
Enter-PSSession AD1 -Credential bidon@dawan.local

#...

Exit-PSSession

# Stocker le credential dans une variable
Get-Command *-crede*

# Demande un login/mot de passe
# pas de validation du login/mot de passe sur une source d'identité
$cred = Get-Credential 
$cred = Get-Credential -UserName dawan\bidon
# $cred.Password
# $cred.GetNetworkCredential().Password

New-ADGroup -Name david_test -Path 'ou=david,dc=dawan,dc=local' -GroupCategory Security -GroupScope Global -Credential $cred

New-ADOrganizationalUnit -Name DSI -Path 'ou=david,dc=dawan,dc=local' -Credential $cred


# Stockage pérenne login/mdp -> Export-CliXml
# Get-Credential -UserName dawan\bidon | Export-Clixml credential.xml

# Lire le fichier credential:

$newcred = Import-Clixml .\credential.xml
$newcred
Get-ADDomain -Credential $newcred





# Factorisation des paramètres des cmdlets

Get-ADDomain -Server AD1.dawan.local -Credential $newcred
Get-ADGroup -Filter * -SearchBase 'ou=david,dc=dawan,dc=local' -Server AD1.dawan.local -Credential $newcred
Get-ADUser -Filter * -SearchBase 'ou=david,dc=dawan,dc=local' -Server AD1.dawan.local -Credential $newcred
Get-ADOrganizationalUnit -Filter * -SearchBase 'ou=david,dc=dawan,dc=local' -Server AD1.dawan.local -Credential $newcred

# le code devient :
$PSDefaultParameterValues = @{
  # 'cmdlets avec jokers:nom du paramètre' = valeur  
    'Get-AD*:Credential' = $newcred
    'Get-AD*:SearchBase' = 'ou=david,dc=dawan,dc=local' 
    '*-AD*:Server' = 'AD1.dawan.local'
    '*:Confirm' = $false
}

Get-ADDomain
Get-ADDomain -Credential david@dawan.local # remplace la valeur proposée par défaut
Get-ADGroup -Filter *
Get-ADUser -Filter *
Get-ADOrganizationalUnit -Filter *




# Session WinRM : utilisation en script

# Utilise le jeton d'identité courant
Invoke-Command -ComputerName AD2.dawan.local -ScriptBlock {
    Get-ADDomain
    Get-ADGroup -Filter * -SearchBase 'ou=david,dc=dawan,dc=local'
    Get-ADUser -Filter * -SearchBase 'ou=david,dc=dawan,dc=local'
    Get-ADOrganizationalUnit -Filter * -SearchBase 'ou=david,dc=dawan,dc=local'
}

New-PSSession -ComputerName ad1 -SSHTransport

# ouverture d'un session
$session = New-PSSession -ComputerName AD1 -Credential $cred
$session = New-PSSession -ComputerName AD1, AD2 -Credential $cred
$session

Invoke-Command -Session $session -ScriptBlock {
    Get-ADDomain
    Get-ADGroup -Filter * -SearchBase 'ou=david,dc=dawan,dc=local'
    Get-ADUser -Filter * -SearchBase 'ou=david,dc=dawan,dc=local'
    Get-ADOrganizationalUnit -Filter * -SearchBase 'ou=david,dc=dawan,dc=local'
}

Invoke-Command -Session $session -FilePath .\remotescript.ps1
Invoke-Command -Session $session -FilePath .\remotescript.ps1 -ArgumentList 'c:\tutu.txt'
# Utilisation du mappage positionnel des paramètres

$file = 'c:\david'
Invoke-Command -Session $session -ScriptBlock {
    New-Item $args[0] -ErrorAction SilentlyContinue
} -ArgumentList $file
Invoke-Command -Session $session -ScriptBlock {
    param($file)
    New-Item $file -ErrorAction SilentlyContinue
} -ArgumentList $file

# utilisation de la portée $using: importe le contexte des variables de la machine source vers la machine de destination
Invoke-Command -Session $session -ScriptBlock {
    New-Item $using:file -ErrorAction SilentlyContinue
}


# Fermeture de la session
Remove-PSSession $session
$session



# PSRP : PowerShell Remote Protocol (utilisation du protocol WinRM)
# Valable pour les cmdlets de gestion des serveurs avec le param -CimSession

$cimsession = New-CimSession -ComputerName AD1 -Credential $cred

Get-SmbShare -CimSession $cimsession
New-Item \\ad1\c$\Shares -ItemType Directory
New-SmbShare -CimSession $cimsession -Name Shares -Path c:\shares -FullAccess 'Everyone'

Remove-CimSession $cimsession



