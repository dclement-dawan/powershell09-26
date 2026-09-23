<# Dans le profil utilisateur :

Afficher la liste des IPv4 de votre ordinateur:

Adresses IPv4 : 192.168.1.233, 192.168.56.1, 172.20.12.234

V1 : Powershell
Get-NetIpAddress

V2 : WMI
Get-WmiObject -Class Win32_NetworkAdapterConfiguration
Get-CimInstance -Class Win32_NetworkAdapterConfiguration

V3 :
ipconfig.exe

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

