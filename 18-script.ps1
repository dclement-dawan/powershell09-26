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
    [string]$param2 = 'a'
)

# traitement...
Write-Output $param1, $param2

# permet de générer un exitcode (variable $LASTEXITCODE)
exit 0

# SIG # Begin signature block
# MIIFkgYJKoZIhvcNAQcCoIIFgzCCBX8CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDwpTzcQrKxgH8R
# RWut79UGzlpb1qfH1qu6+ouL1tndfqCCAwgwggMEMIIB7KADAgECAhBCs5+taIRp
# pUJuViUhEzODMA0GCSqGSIb3DQEBBQUAMBoxGDAWBgNVBAMMD0NvZGVTaWduaW5n
# Q2VydDAeFw0yNTA0MDkwNzQyMjlaFw00NTA0MDkwNzUyMjhaMBoxGDAWBgNVBAMM
# D0NvZGVTaWduaW5nQ2VydDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
# APufCZ++tkdUvdaE9AYdqDpjOHnARvpj12Bjbq6NEhH09qrQdAFLpnGAb+Ea+OAA
# /y9vF43JjB+3Xg38icgwMs+I3iAaHG56oCCOmr4iQeQ5Z5dlPLRBMN2ZuRFghhEZ
# TVbkyHN9pW89ZSlItu68mFsKcTegXHyNqxIsRinMIwney5W6O7OgHRlYTIzWk6pn
# rc985IGAOpgTLGxO+5O4gjdBx8pGjc0CitrwUps+Erofu0T+/OXj7ImZ5wnVLX89
# i+Pr8RRMXw2EdepB54xtYGXZIen7Rf0UewGBMuBkEbcGHY4IOd979ab/ymCJiRL2
# I5BlMn10A8mf1G9cLT+8cv0CAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1Ud
# JQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBSgoGcq+ny2OESW0rzK9Z3Nh5KCUTAN
# BgkqhkiG9w0BAQUFAAOCAQEABQ4nAtCPkTy8LrGRu6HNwgdZecDhTNZMBqMR6yJK
# H2/ZN88FV3N/aD8UmLggdUBto4Quz6JG2Vwfm+yL2BZiI8NdvIVCqF9M8jzzAQuQ
# A6ZNEZLRcHHJQijfE6a8Cda+HuJkPABQVtVkcFD6QKA4KYiBgqtAmWkh080alSo1
# TKYKY3Swf/uVfJTgwb4J0z0BEF66bQHvB/EZKe1tvPKElAPW47IBLxXgVtj/9hph
# 1/h7FhwQ+DdXhAh64biPwc3knvNMeW9vXJ4ZmVGQjB1JWph2OM8vTpl2h6vK50MP
# 0tpGrWTgD40r/F9UBlAFKQ8mkZH/vSPDUyNuiZuUAuDy/TGCAeAwggHcAgEBMC4w
# GjEYMBYGA1UEAwwPQ29kZVNpZ25pbmdDZXJ0AhBCs5+taIRppUJuViUhEzODMA0G
# CWCGSAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZI
# hvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcC
# ARUwLwYJKoZIhvcNAQkEMSIEIBSIRFD7CSO1rPkoVrx6xWXAhzZnVJ+jAq45YQaX
# mPmIMA0GCSqGSIb3DQEBAQUABIIBAPJ2hydmCFPP9lD+aWFNyULeyvMaZ+VgK2Kq
# FqJA37dhKY8n+CW4HN3Ra2UoEXi6kutU60V0WLqOPJrSBlw9FzGEUtgN+eRZui/d
# XlYIqwhJkidrHo4HTxhaGhb1xN31q+UuAOO2Stg6Xk71Ne1jV1bP+8AxrNkpuruY
# aV5BQuzkPGIbgerXcjx6R7+w+d9cIPWku2/2xq/JqAZNIuq1+yU/PfTMHfsVyHhF
# +Vk9EccW1qO5P3xWOF8ueWyObPyuMDQk5Wz76eWt6ZaFgXSii1SkOL3T9xw+0A1j
# nghxEljWNNduGO9xV658PYs1TqJzlJf0HQa4MtpKrlNLr4qQu4Y=
# SIG # End signature block
