# Q1: Créer 200 fichiers nommés 1.log à 200.log dans un dossier nommé "temporaire"

New-Item temporaire -ItemType Directory
# measure-command{
for ($i = 1; $i -le 200; $i++) {
    New-Item -Path temporaire -Name "$i.log"
}
#}
# ou
$i = 1
while ($i -le 200) {
    New-Item -Path temporaire -Name "$i.log"
    $i++
}
# ou avec un intervalle
foreach ($i in (1..200)) {
    New-Item -Path temporaire -Name "$i.log"
}
# ou
# Measure-Command{
1..200 | ForEach-Object {
    New-Item -Path temporaire -Name "$_.log"
}
# }

# Q2: Suite à une erreur, on va renommer les fichiers ainsi :
#    1.log devient  0001.log
#           ...
#  200.log devient  0200.log


'1.log'.PadLeft(8, '0')
'200.log'.PadLeft(8, '0')

# exécution en dry-run
Rename-Item -Path 1-intro.ps1 -NewName test.ps1 -WhatIf


foreach ($file in (Get-ChildItem -Path .\temporaire -Filter *.log -File)) {
    $NewName = $file.Name.PadLeft(8, '0')
    Rename-Item -Path $file -NewName $NewName -WhatIf
}
# ou
Get-ChildItem -Path .\temporaire -Filter *.log -File |
    ForEach-Object {
        $NewName = $_.Name.PadLeft(8, '0')
        Rename-Item -Path $_ -NewName $NewName -WhatIf
    }
# ou
ls temporaire\*.log | % {ren $_ $_.Name.PadLeft(8, '0')}
