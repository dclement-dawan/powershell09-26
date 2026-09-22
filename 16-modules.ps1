#Requires -Modules CustomModule
# $env:PsModulePath += ";.\modules"

# [System.Environment]::GetEnvironmentVariable('PSModulePath')

# Import-Module CustomModule
# Import-Module .\modules\CustomModule\CustomModule.psd1

Get-Manufacturer -MacAddress '00-50-56-C0-0F-12'
