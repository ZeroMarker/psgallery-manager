@{
    RootModule        = 'PsGalleryManager.psm1'
    ModuleVersion     = '1.0.2'
    GUID              = 'a3e8f2b1-7c4d-4e6a-9f1b-2d8c5a3e7f0b'
    Author            = 'ZeroMarker'
    CompanyName       = 'ZeroMarker'
    Copyright         = '(c) 2026 ZeroMarker. All rights reserved.'
    Description       = 'A PowerShell module for managing modules from the PowerShell Gallery. Provides commands to search, install, update, remove, and sync PowerShell Gallery modules with manifest-based environment management.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Export-ModuleManifest',
        'Get-InstalledModuleInfo',
        'Get-PsGalleryModule',
        'Install-PsGalleryModule',
        'Remove-PsGalleryModule',
        'Search-PsGalleryModule',
        'Sync-PsGalleryModules',
        'Update-PsGalleryModule'
    )
    CmdletsToExport   = @()
    VariablesToExport  = @()
    AliasesToExport    = @()
    PrivateData        = @{
        PSData = @{
            Tags       = @('PSGallery', 'Module', 'Management', 'PackageManagement', 'Windows', 'Linux', 'MacOS')
            ProjectUri = 'https://github.com/ZeroMarker/psgallery-manager'
            LicenseUri = 'https://github.com/ZeroMarker/psgallery-manager/blob/main/LICENSE'
            ReleaseNotes = 'https://github.com/ZeroMarker/psgallery-manager/blob/main/CHANGELOG.md'
        }
    }
}
