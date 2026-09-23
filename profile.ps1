

# Ajout de raccourcis clavier

# ctrl + d
Set-PSReadLineKeyHandler -Chord 'ctrl+n' -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
    [Microsoft.Powershell.PSConsoleReadLine]::Insert("Get-Date")
    [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Chord 'ctrl+d' -Function DeleteCharOrExit


$d1 = Measure-Command {
$tab = (Get-NetIPAddress -AddressFamily IPv4 -PrefixOrigin Dhcp, Manual).IPAddress
Write-Host 'Adresses IPv4 :' ($tab -join ', ') -BackgroundColor Red
}

$d2 = Measure-Command {
$tab = (Get-CimInstance -Class Win32_NetworkAdapterConfiguration).IPAddress  |
    Select-String -NotMatch ':' |
    Select-String -NotMatch '^$'
Write-Host  'Adresses IPv4 :' ($tab -join ', ') -BackgroundColor Yellow
}

$d3 = Measure-Command {
$tab = (ipconfig.exe | Select-String 'IPv4') -split ': ' |
    Select-String -NotMatch 'IPv4'
Write-Host  'Adresses IPv4 :' ($tab -join ', ') -BackgroundColor Green
}

Write-Host "Durée v1 $($d1.TotalMilliseconds)  v2 $($d2.TotalMilliseconds)  v3 $($d3.TotalMilliseconds)"




Set-PSReadLineKeyHandler -Chord 'ctrl+t' -ScriptBlock {
    $Proc = [int]((Get-Counter '\Processeur(_total)\% temps processeur').CounterSamples.CookedValue)
    $KBAvailable = (Get-Counter '\Mémoire\Kilo-octets disponibles').CounterSamples.CookedValue
    $KBTotal = (Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize
    $PercentUsed = [int](($KBTotal - $KBAvailable) / $KBTotal * 100)
    Write-Host "CPU:${Proc}% Memory:${PercentUsed}%"
    [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
}





Set-PSReadlineKeyHandler -key 'Ctrl+o','Ctrl+O' `
    -Description 'Open PowerShell session with user admin' `
    -ScriptBlock {
        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        if ($line.trim().length -ne 0) {
            [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
            [Microsoft.Powershell.PSConsoleReadLine]::Insert("Enter-PSSession -ComputerName $line -Credential admin")
            [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
        }
    }

Set-PSReadlineKeyHandler -Key F1,"Shift+F1","Ctrl+F1" `
    -BriefDescription Help `
    -LongDescription 'Show command help' `
    -ScriptBlock {
        param($key, $arg)

        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        $command = $line.Split(' ')[0]

        $option = ""
        switch ($key.Modifiers) {
            "Shift" {$option = "-Showwindow"}
            "Control" {$option = "-Online"}
        }

        [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
        [Microsoft.Powershell.PSConsoleReadLine]::Insert("Get-Help $command $option")
        [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
    }
