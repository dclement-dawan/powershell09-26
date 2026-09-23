

# Ajout de raccourci clavier

# ctrl + d
Set-PSReadLineKeyHandler -Chord 'ctrl+n' -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
    [Microsoft.Powershell.PSConsoleReadLine]::Insert("Get-Date")
    [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Chord 'ctrl+d' -Function DeleteCharOrExit
