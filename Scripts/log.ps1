<#
.SYNOPSIS
    Écrit un log dans le fichier c:\scripts\script.log
.PARAMETER LogLevel
    Le niveau de criticité du log : Information, Warning, Error
.PARAMETER Message
    Le message du log
.EXAMPLE
    PS C:\> C:\Scripts\log.ps1 -Message argh -LogLevel Error
#>
#Requires -Modules CustomModule

[CmdletBinding()]
param(
    [ValidateSet('Error','Warning','Information')]
    [string]$LogLevel = 'Information',

    [Parameter(Mandatory)]
    [string]$Message
)
$LogFile = 'c:\scripts\script.log'

Write-Log -LogFile $LogFile -LogLevel $LogLevel -Message $Message

# Externalisé dans le module CustomModule
# $log = @()
# $log += Get-Date -Format 'dd/MM/yyyy'
# $log += Get-Date -Format 'HH:mm:ss'
# $log += $env:USERNAME
# $log += HOSTNAME.EXE
# $log += $LogLevel
# $log += $Message

# Add-Content -Path $LogFile -Value ($log -join ';') -Encoding utf8
