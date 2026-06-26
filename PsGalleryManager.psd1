@{
    RootModule        = 'PsGalleryManager.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = [guid]::NewGuid().ToString()
    Author            = 'ZeroMarker'
    Description       = 'PowerShell Gallery module management tool'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Get-PsGalleryModule',
        'Install-PsGalleryModule',
        'Update-PsGalleryModule',
        'Remove-PsGalleryModule',
        'Search-PsGalleryModule',
        'Get-InstalledModuleInfo',
        'Sync-PsGalleryModules'
    )
    CmdletsToExport   = @()
    VariablesToExport  = @()
    AliasesToExport    = @()
    PrivateData        = @{
        PSData = @{
            Tags       = @('PSGallery', 'Module', 'Management', 'PackageManagement')
            ProjectUri = 'https://github.com/ZeroMarker/psgallery-manager'
            LicenseUri = 'https://github.com/ZeroMarker/psgallery-manager/blob/main/LICENSE'
        }
    }
}
