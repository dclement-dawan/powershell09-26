# For
for ($i = 0; $i -lt 10; $i++) { # de 0 à 9
    $i
}
for ($i = 1; $i -le 10; $i++) { # de 1 à 10
    $i
}
for ($i = 1; $i -le 10; $i+=2) { # par 2
    $i
}
for ($i = 10; $i -gt 0; $i--) { # compte à rebours
    $i
}

# While, do...while et do...until
# de 0 à n traitements :
$c= ''
while ($c -ne 'x') {
    $c = Read-Host 'x pour sortir'
}

# de 1 à n traitements :
do {
    $c = Read-Host 'x pour sortir'
} while ($c -ne 'x')

do {
    $c = Read-Host 'x pour sortir'
} until ($c -eq 'x')



for ($compteur = 0; $compteur -le 10; $compteur++) {
    write-host 'hello world!'
}


# foreach
$tab = 56,78,34,4,56,1
foreach($item in $tab) { # le nom de la variable de parcours est libre
    $item * $item
    # break  # permet de mettre fin prématurément à une boucle
}

foreach($process in (Get-Process)) {
    $process.Name
    $process.id
}

# Avec une barre de progression
$ProgressPreference = 'Continue'

$tabProcess = Get-Process
$nb = $tabProcess.Count
$i = 1
foreach($process in $tabProcess) {
    Write-Progress -Activity 'Traitement des processus' `
        -Status "Process $($process.Name) $i/$nb" `
        -PercentComplete ([int]($i / $nb * 100))
    $process.Name
    $process.id
    Start-Sleep -Milliseconds 100
    $i++
}

