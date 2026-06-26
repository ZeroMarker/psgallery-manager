# PsGalleryManager

A PowerShell module for managing modules from the PowerShell Gallery.

## Installation

```powershell
Install-Module -Name PsGalleryManager -Scope CurrentUser
```

## Features

- Search modules in the PowerShell Gallery
- Install, update, and remove modules
- View installed module information
- Sync modules across environments

## Usage

```powershell
# Search for a module
Search-PsGalleryModule -Name 'PSReadLine'

# Install a module
Install-PsGalleryModule -Name 'PSReadLine' -Scope CurrentUser

# Update all installed modules
Update-PsGalleryModule

# List installed modules with details
Get-InstalledModuleInfo

# Remove a module
Remove-PsGalleryModule -Name 'PSReadLine'
```

## Commands

| Command | Description |
|---------|-------------|
| `Search-PsGalleryModule` | Search for modules in the PowerShell Gallery |
| `Install-PsGalleryModule` | Install a module from the PowerShell Gallery |
| `Update-PsGalleryModule` | Update installed modules |
| `Remove-PsGalleryModule` | Remove an installed module |
| `Get-PsGalleryModule` | Get module details from the Gallery |
| `Get-InstalledModuleInfo` | List installed modules with version info |
| `Sync-PsGalleryModules` | Sync modules from a manifest file |

## License

MIT
