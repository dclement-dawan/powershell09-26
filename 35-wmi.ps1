# WMI

Get-CIMInstance `
    -Query "select size,freespace from win32_LogicalDisk where DeviceID='C:'" |
    fl


Get-ADComputer -Filter * -Properties * |
    Select-Object Name, OperatingSystem, IPv4Address, LastLogonDate, `
        @{Name='DiskCPercentUsed'; Expression={
            if (Test-NetConnection -ComputerName $_.Name -Port 5985 -InformationLevel Quiet) {
                $result = Get-CIMInstance -ComputerName $_.Name -Query "select size,freespace from win32_LogicalDisk where DeviceID='C:'"
                return ([Math]::Round(($result.size-$result.freespace)/$result.size*100, 2))
            } else {return 'N/A'}
        }} |
    Where-Object DiskCPercentUsed -gt 5 | 
    Sort-Object DiskCPercentUsed -Descending |
    Export-CSV ordis.csv -Delimiter ';' -NoTypeInformation -Encoding utf8

.\ordis.csv




Get-Counter -ListSet '*network*'

(Get-Counter -ListSet 'network adapter').Counter
(Get-Counter -ListSet 'network adapter').PathsWithInstances

Get-Counter -Counter '\Network Adapter(Microsoft Hyper-V Network Adapter)\Bytes Total/sec',
'\Network Adapter(Microsoft Hyper-V Network Adapter)\Bytes Sent/sec',
'\Network Adapter(Microsoft Hyper-V Network Adapter)\Bytes Received/sec'

