# $env:PsModulePath += ";.\modules"

@{ # snippet : manifest
    RootModule = 'CustomModule.psm1'
    Author = 'Moi <dclement@dawan.fr>'
    CompanyName = 'Dawan'
    ModuleVersion = '1.0'
    # Utiliser la cmdlet : New-Guid
    GUID = '0711d7fa-395b-45a0-8876-a27d13134697'
    Copyright = '2026 Copyright Holder'
    Description = 'Module à usage pédagogique'
    # PowerShellVersion = ''
    CompatiblePSEditions = @('Desktop', 'Core')
    FunctionsToExport = @('Get-Manufacturer', 'Write-Log')
    AliasesToExport = @('*')  # 'gma'
    VariablesToExport = @('')
    # HelpInfoURI = ''
}
