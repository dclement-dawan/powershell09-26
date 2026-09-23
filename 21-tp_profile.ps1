<# Dans le profil utilisateur :

Afficher la liste des IPv4 de votre ordinateur:

Adresses IPv4 : 192.168.1.233, 192.168.56.1, 172.20.12.234

V1 : Powershell
Get-NetIpAddress
#>

# Get-NetIPAddress -AddressFamily IPv4 -PrefixOrigin Dhcp, Manual | Select-Object IPAddress
$tab = (Get-NetIPAddress -AddressFamily IPv4 -PrefixOrigin Dhcp, Manual).IPAddress
Write-Host 'Adresses IPv4 :' ($tab -join ', ')
<#
V2 : WMI
Get-WmiObject -Class Win32_NetworkAdapterConfiguration
Get-CimInstance -Class Win32_NetworkAdapterConfiguration
#>

$tab = (Get-CimInstance -Class Win32_NetworkAdapterConfiguration).IPAddress  |
    Select-String -NotMatch ':' |
    Select-String -NotMatch '^$'
Write-Host  'Adresses IPv4 :' ($tab -join ', ')

<#

V3 :
ipconfig.exe
#>

$tab = (ipconfig.exe | Select-String 'IPv4') -split ': ' |
    Select-String -NotMatch 'IPv4'
Write-Host  'Adresses IPv4 :' ($tab -join ', ')


<#

Mesurer la durée des différentes version avec Measure-Command
=============================================

Bonus :
Ajouter un raccourci clavier : ctrl+t

Permettant d'afficher le pourcentage CPU
et le pourcentage mémoire utilisé actuellement

Utiliser la cmdlet Get-Counter

# Chercher des compteurs
Get-Counter -ListSet 'Mém*'

# Récupérer la valeur d'un compteur
Get-Counter '\Processeur(_total)\% temps processeur'
(Get-Counter '\Processeur(_total)\% temps processeur').CounterSamples.CookedValue
#>



(Get-Counter '\Processeur(_total)\% temps processeur').CounterSamples.CookedValue


(Get-Counter -ListSet 'Mémoire').Counter

$KBAvailable = (Get-Counter '\Mémoire\Kilo-octets disponibles').CounterSamples.CookedValue
$KBTotal = (Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize

$PercentUsed = ($KBTotal - $KBAvailable) / $KBTotal * 100
Write-Host $PercentUsed

# Arrondis :

[int](59.58416070921954)             # arrondi monétaire à l'entier
[Math]::Round(59.58416070921954)     # arrondi monétaire à l'entier
[Math]::Round(59.58416070921954, 2)  # arrondi monétaire avec 2 chiffres après la virgule
[Math]::Ceiling(59.58416070921954)   # arrondi plafond
[Math]::Floor(59.58416070921954)     # arrondi plancher
