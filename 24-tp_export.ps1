# 1- Exporter en CSV les fichiers PS1 de votre profil de l'année 2026

Get-ChildItem -Path $env:USERPROFILE -Filter *.ps1 -Recurse -File |
    Select-Object CreationTime  |
    Export-Csv -Path fileps1.csv -Encoding utf8


Get-ChildItem -Path $env:USERPROFILE -Filter *.ps1 -Recurse -File |
    Out-GridView

Get-ChildItem -Path $env:USERPROFILE -Filter *.ps1 -Recurse -File |
    Select-Object Name, CreationTime |
    Where-Object CreationTime -ge '01/01/2026' |
    Where-Object CreationTime -le '12/31/2026 23:59:59' |
    Export-Csv -Path fileps1.csv -Encoding utf8
# ou
Get-ChildItem -Path $env:USERPROFILE -Filter *.ps1 -Recurse -File |
    Select-Object Name, CreationTime |
    Where-Object { $_.CreationTime.Year -eq 2026 } |
    Export-Csv -Path fileps1.csv -Encoding utf8
# ou
Get-ChildItem -Path $env:USERPROFILE -Filter *.ps1 -Recurse -File |
    Select-Object Name, CreationTime, 
        @{name='CreationYear'; Expression={$_.CreationTime.Year}} |
    Where-Object { $_.CreationYear -eq 2026 } |
    Export-Csv -Path fileps1.csv -Encoding utf8


# 2- Exporter en CSV les fichiers de votre profil
# de plus de 1MB en triant par taille descendante
Get-ChildItem -Path $env:USERPROFILE -Recurse -File |
    Select-Object Name, Length |
    Where-Object -FilterScript { $_.Length -gt 1MB } |
    Sort-Object -Property Length -Descending |
    Export-Csv -Path file1MB.csv -Encoding utf8

# 3- Afficher les fichiers de votre profil
# de plus de 1MB et les grouper par extension
Get-ChildItem -Path $env:USERPROFILE -Recurse -File |
    Where-Object -FilterScript { $_.Length -gt 1MB } |
    Group-Object -Property Extension


# 4- Exporter en CSV les 10 fichiers les plus gros
# en triant par taille descendante
Get-ChildItem -Path $env:USERPROFILE -Recurse -File |
    Sort-Object -Property Length -Descending |
    Select-Object -First 10 -Property Name, Length |
    Export-Csv -Path fileTop10.csv -Encoding utf8




# 5- Exporter les ordinateurs du domaine en JSON avec les informations suivantes
# Nom, OS, date de dernier boot, IPv4

help Get-ADComputer
Get-ADComputer Win11
Get-ADComputer Win11 | fl *
Get-ADComputer Win11 -Properties * | fl oper*
Get-ADComputer Win11 -Properties * | fl *date*
Get-ADComputer Win11 -Properties * | fl *ip*

Get-ADComputer -filter *  # toutes les propriétés ne sont pas visibles
Get-ADComputer -filter * -Properties *

Get-ADComputer -filter * -Properties OperatingSystem, IPv4Address, LastLogonDate


Get-ADComputer -filter * -Properties OperatingSystem, IPv4Address, LastLogonDate |
    Select-Object Name, OperatingSystem, IPv4Address, LastLogonDate |
    ConvertTo-Json |
    Out-File ordis.json -Encoding utf8

# Avec formatage de la date
Get-ADComputer -filter * -Properties OperatingSystem, IPv4Address, LastLogonDate |
    Select-Object Name, OperatingSystem, IPv4Address, 
        @{Name='LastLogonDate'; Expression={Get-Date $_.LastLogonDate -Format 'dd/MM/yyyy'}} |
    ConvertTo-Json |
    Out-File ordis.json -Encoding utf8


# 6- Exporter les ordinateurs du domaine en HTML avec les informations suivantes
# Nom, OS, date de dernier boot, IPv4
# Ajouter la taille de la RAM avec une propriété calculée en GB :
#  Get-CimInstance -ComputerName ... -Class Win32_ComputerSystem

Get-CimInstance -ComputerName AD1 -Class Win32_ComputerSystem

$mem = (Get-CimInstance -ComputerName AD1 -Class Win32_ComputerSystem).TotalPhysicalMemory

$mem / 1GB

[int]($mem / 1GB)


Test-NetConnection AD1 -Port 5985
Test-NetConnection AD1 -Port 5985 -InformationLevel Quiet
Test-Connection AD1 -Count 1 -Quiet

Get-ADComputer -filter * -Properties OperatingSystem, IPv4Address, LastLogonDate |
    Select-Object Name, OperatingSystem, IPv4Address, 
        @{Name='LastLogonDate'; Expression={Get-Date $_.LastLogonDate -Format 'dd/MM/yyyy'}},
        @{Name='MemGB'; Expression={
            $mem = (Get-CimInstance -ComputerName $_.Name -Class Win32_ComputerSystem).TotalPhysicalMemory
            return [int]($mem / 1GB)
        }} |
    ConvertTo-HTML -PreContent '<h1>Liste des ordi:</h1>' `
        -Head '<style>table{border-collapse: collapse}
         th,td {border: 1px solid black }</style>' |
    Out-File ordis.html -Encoding utf8

