# Comparaison

# Attention aux transformations de types automatiques
'1' + 1 # 11
1 + '1' # 2

'1' -eq 1 # $true
'tomate' -eq 'TOMATE'  # $true
'tomate' -ceq 'TOMATE' # $false, case-sensitive equal



$x = 5
if ($x -eq 5) {
    Write-Host 'x vaut 5'
} elseif ($x -eq 6) {
    Write-Host 'x vaut 6'
} else {
    Write-Host 'pas traité'
}



$x = 1
switch ($x) { # pour des cas de la variable faire...
    1 { Write-Host 'x vaut 1' } # si $x égal à 1
    2 { Write-Host 'x vaut 2' }
    3 { Write-Host 'x vaut 3' }
    default { Write-Host 'x vaut autre chose' }
}
