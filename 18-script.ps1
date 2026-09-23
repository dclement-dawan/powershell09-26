<#
.SYNOPSIS
    Documentation du script
.DESCRIPTION
    ...
.EXAMPLE
    ...
.LINK
    https://dawan.fr/formations/powershell
#>

# pré-requis
#Requires -RunAsAdministrator
#Requires -PSEdition Core
#Requires -Version 7.6
# Présence d'un module version quelconque
#Requires -Modules CustomModule
# version minimum
#Requires -Modules @{ ModuleName='CustomModule2'; ModuleVersion='1.0'}
# version exacte
#Requires -Modules @{ ModuleName='CustomModule2'; RequiredVersion='1.0.0'}
# version maxi
#Requires -Modules @{ ModuleName='CustomModule2'; MaximumVersion='1.1'}

# paramètres d'entrée
[CmdletBinding()]
param (
    [parameter(Mandatory)]
    [int]$param1,

    [ValidateSet('a','b','c')]
    [string]$param2='a'
)

# traitement...
Write-Output $param1, $param2

# permet de générer un exitcode (variable $LASTEXITCODE)
exit 0
