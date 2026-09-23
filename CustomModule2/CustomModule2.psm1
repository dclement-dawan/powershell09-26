function Get-Manufacturer2 {
<#
.SYNOPSIS
    Récupère le nom du fabricant d'un équipement réseau en fonction de l'adresse MAC
.LINK
        https://github.com/dclement-dawan/powershell09-26
.PARAMETER MacAddress
    Une adresse MAC valide 12 chiffres hexadécimaux en majuscule ou minuscule avec séparateur ':', '-', ' ' ou sans séparateur.
.PARAMETER DownloadOUI
    Indique s'il faut forcer le téléchargement du fichier oui.txt depuis le site de IEEE
.EXAMPLE
    PS C:\>Get-Manufacturer -MacAddress '00-50-56-C0-0F-12'
    VMware, Inc.
.EXAMPLE
    PS C:\>Get-Manufacturer 'C4:E9:0A:96:B1:C3'
    D-Link International
#>
    [CmdletBinding()]
    param (
        [ValidateScript({if ($_ -NotMatch '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$') {throw "Format d'adresse MAC invalide"} else {$true} })]
        # [ValidatePattern('^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$')]
        [Parameter(Mandatory)]
        [String]$MacAddress,

        [switch]$DownloadOUI
    )
    $OUIFile = "$PSScriptRoot\oui.txt"
    $UriOuiFile = 'https://standards-oui.ieee.org/'
    # Si $DownloadOUI est vrai , alors supprimer le fichier oui.txt
    if ($DownloadOUI) {
        Write-Verbose "Le fichier $OUIFIle doit être téléchargé"
        Remove-Item $OUIFile -Force -ErrorAction SilentlyContinue
    }

    # Si le fichier oui.txt existe et a plus 15 jours alors le supprimer
    if (Test-Path $OUIFile) {
        if ((Get-Item $OUIFile).CreationTime -lt (Get-Date).AddDays(-15)) {
            Write-Verbose "Le fichier $OUIFIle est trop ancien"
            Remove-Item $OUIFile -Force -ErrorAction SilentlyContinue
        }
    }
    # Vérifier la présence du fichier oui.txt (Test-Path), s'il n'existe pas le télécharger
    if (-not(Test-Path $OUIFile)) {
        Write-Verbose "Téléchargement de fichier $OUIFile"
        Invoke-WebRequest -URI $UriOuiFile -OutFile $OUIFile
    }

    Write-Verbose "Adresse MAC reçue: $MacAddress"
    # $MacAddress = '00-50-56-C0-0F-12'
    $CleanMacAddress = $MacAddress -replace '-|:| ', ''
    Write-Verbose "Adresse MAC nettoyée: $CleanMacAddress"
    $MacPrefix = $CleanMacAddress.Substring(0, 6)
    Write-Verbose "Préfixe d'adresse MAC: $MacPrefix"
    $Line = Select-String -Pattern $MacPrefix -Path $OUIFile -SimpleMatch | Out-String
    Write-Verbose "Résultat de la recherche dans le fichier: $Line"
    if ($line) {
        $Manufacturer = ($Line -split "`t+")[1]
    } else {
        $Manufacturer = 'N/A'
    }
    Write-Debug "Constructeur trouvé : $Manufacturer"
    return $Manufacturer
}
