# personnaliser les variables
[CmdletBinding(SupportsShouldProcess)]
param(
    $Partage = 'Dav_share',
    $Server = 'AD1',
    $Identite = 'dawan\david'
)
trap { # gestionnaire global d'erreur
    $logfile = (Split-Path $MyInvocation.MyCommand.Name -LeafBase)+'.log'
    $ligne = @{
                date = Get-Date -Format 'dd/MM/yyyy'
                heure =  Get-Date -Format 'HH:mm:ss'
                Erreur= $_ | Out-String
            } | ConvertTo-Csv -NoHeader -Delimiter ';'
    Add-Content -Path $logfile -Value $Ligne
    throw $_.Exception
}
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Set-StrictMode -Version Latest

$UNCPath = "\\$Server\c$\shares\$Partage"
$LocalPath = "c:\shares\$Partage"
$CredentialFile = 'credential.xml'

if (-not(Test-NetConnection -ComputerName $Server -Port 445 -InformationLevel Quiet)) {
    throw "Le serveur $Server n'est pas accessible pour SMB(TCP/445)"
}
if (-not(Test-NetConnection -ComputerName $Server -Port 5985 -InformationLevel Quiet)) {
    throw "Le serveur $Server n'est pas accessible pour WinRM(TCP/5985)"
}

if (Test-Path $CredentialFile) {
    # si le fichier est trop ancien
    if ((Get-Item $CredentialFile).CreationTime -lt (Get-Date).AddDays(-15)) {
        Remove-Item $CredentialFile
    } else { # sinon chargement du fichier xml
        $cred = Import-Clixml $CredentialFile
    }
} 

if (-not(Test-Path $CredentialFile)) {
    $cred = Get-Credential $Identite
    $cred | Export-Clixml $CredentialFile
}

try {
    # Permet de tester le credential sur la source de données AD
    Get-ADDomain -Credential $cred | Out-Null
} catch {
    throw "Les login/mot de passe sont incorrects"
} finally {
    Remove-Item $CredentialFile -ErrorAction Ignore
}



# 1- Créer le dossier $Partage via la partage administratif \\ad1\c$\shares
if ($PSCmdlet.ShouldProcess($UNCPath, 'Création du dossier')) {
    New-Item $UNCPath -ItemType Directory | Out-Null
}

# 2- Avec une session CIM le partager via SMB dans c:\shares sur AD1.dawan.local (Get-Command *-smb*)
$cimsession = New-CimSession -ComputerName $Server -Credential $cred
if ($PSCmdlet.ShouldProcess($Partage, 'Création du partage')) {
    New-SmbShare -CimSession $cimsession -Name $Partage -Path $LocalPath -FullAccess Everyone  | Out-Null
}
# 3- Avec une session WinRM
# Fixer les permissions NTFS en controle total pour votre utilisateur
# et désactiver l'héritage  (module NTFSSecurity)
# (get-acl $Path).Access | fl *
$session = New-PSSession -ComputerName $Server -Credential $cred
Invoke-Command -Session $session -ScriptBlock {
    Add-NTFSAccess -Path $using:LocalPath -Account $using:Identite -AccessRights FullControl
    Set-NTFSOwner -Path $using:LocalPath -Account $using:Identite
    Disable-NTFSAccessInheritance -Path $using:LocalPath -RemoveInheritedAccessRules
    Add-NTFSAccess -Path $using:LocalPath -Account 'NT AUTHORITY\System' -AccessRights FullControl
}
 
# 4- Avec une session WinRM
# Fixer un quota "10 GB Limit" sur votre partage : cf get-command *FSRM*
#   FSRM : File Server Resource Manager
if ($PSCmdlet.ShouldProcess("10 GB Limit sur $LocalPath", 'Création du quota')) {
    Invoke-Command -Session $session -ScriptBlock {
        New-FsrmQuota -Path $using:LocalPath -Template "10 GB Limit" | Out-Null
    }
}
# Avec une session CIM
# Vérifier le partage via une requête WMI sur le serveur
# Get-CimClass -ClassName *share*

# Get-CimClass -CimSession $cimsession -ClassName *share*
Get-CimInstance -CimSession $cimsession -ClassName win32_share | 
    Where-Object Name -eq $Partage |
    Format-List *

# Fermer les sessions
Remove-PSSession $session
Remove-CimSession $cimsession

# Bonus :
# 1- Ajouter un trap pour logguer les erreurs de votre script dans un fichier
# log.txt avec la date et l'heure

# 2- Si le fichier credential.xml a plus de 15 jours, le supprimer
# Si le fichier credential.xml est présent le charger, sinon redemander un credential
# Enregsitrer le credential dans un fichier credential.xml

# 3- ajouter en début de script un test sur l'accessibilité du serveur
# pour les ports SMB TCP/445 et WinRM TCP/5985
# arrêter le script si un des 2 protocoles n'est pas joignable
