[CmdletBinding()]
param(
    $File = 'c:\toto.txt'
)

# $args[] : tableau des paramètres transmis si pas de section param()

New-Item $file -Force -ErrorAction SilentlyContinue
