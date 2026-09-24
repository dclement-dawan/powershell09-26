# mise à jour 


Get-ADUser -Filter * -SearchBase 'ou=David,dc=dawan,dc=local' `
    -Properties OfficePhone, EmailAddress | 
    Select-Object SamAccountName, GivenName, Surname, OfficePhone, EmailAddress |
    Export-Csv màj.csv -NoTypeInformation -Encoding utf8 -Delimiter ';'

Import-CSV .\màj.csv -Delimiter ';'

$tabUsers = Import-CSV .\màj.csv -Delimiter ';'
foreach ($user in $tabUsers) {    
    Set-ADUser `
        -Identity $user.SamAccountName `
        -GivenName $user.GivenName `
        -Surname $user.Surname `
        -EmailAddress $user.EmailAddress `
        -OfficePhone $user.OfficePhone `
        -WhatIf # permet de faire un dry run des commandes
    Write-Host "Set-ADUser -Identity $($user.SamAccountName)
    -GivenName $($user.GivenName) -Surname $($user.Surname)
    -EmailAddress $($user.EmailAddress) -OfficePhone $($user.OfficePhone)"
}









$VerbosePreference = 'Continue'
$tabUsers = Import-CSV .\màj.csv -Delimiter ';'
foreach ($user in $tabUsers) {
    $tabClear = @()
    $params = @{ # Dictionnaire des options de la cmdlet
        Identity = $user.SamAccountName
        GivenName = $user.GivenName
        Surname = $user.Surname
        #WhatIf = $true # permet de faire un dry run des commandes
    }
    if ($user.OfficePhone -ne '') {
        $params += @{OfficePhone = $user.OfficePhone}
    } else {
        $tabClear += 'telephoneNumber'
    }
    if ($user.EmailAddress -ne '') {
        $params += @{EmailAddress = $user.EmailAddress}
    } else {
        $tabClear += 'mail'
    }
    if ($tabClear.Count -ne 0) {$params += @{Clear = $tabClear} }
    Write-Verbose "Paramètres transmis : $($params | Out-String)"
    Set-ADUser @params
}






