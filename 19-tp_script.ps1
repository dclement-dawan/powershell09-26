<#
Créer une tâche planifiée pour exécuter un script C:\scripts\log.ps1
toutes les minutes.

Le script log.ps1 prend 2 paramètres en entrée de type String :
        $Message, obligatoire
        et $LogLevel [ValidateSet('Error','Warning','Information')], valeur par défaut "Information"

Le script ajoute dans un fichier de log c:\scripts\script.log :
    02/10/2024;11:34:54;david;DAVID-PC;Information;message

Date:
    Get-Date -Format 'dd/MM/yyyy'
    Get-Date -UFormat '%Y%m%d'

    Get-Date -Format 'HH:mm:ss'

Écrire dans un fichier:
    Add-Content -Path c:\scripts\script.log -Value 'test' -Encoding UTF8

Nom d'utilisateur :
    $env:USERNAME
    whoami.exe

Nom d'ordinateur :
    $env:ComputerName
    hostname.exe

Tâche planifiée:
pwsh -ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden -File "D:\scripts\log.ps1" -Message "ça marche ?" -LogLevel Information

- Documenter le script (paramètres + exemple)


Bonus :
- Déporter l'écriture des logs dans une fonction Write-Log stockée dans le module powershell CustomModule

La fonction prend 3 paramètres en entrée de type String :
        $LogFile, obligatoire le nom de fichier de log
        $Message, obligatoire
        et $LogLevel [ValidateSet('Error','Warning','Information')], valeur par défaut "Information"
#>
