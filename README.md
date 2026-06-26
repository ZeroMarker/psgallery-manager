# PsGalleryManager

[![CI](https://github.com/ZeroMarker/psgallery-manager/actions/workflows/ci.yml/badge.svg)](https://github.com/ZeroMarker/psgallery-manager/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/ZeroMarker/psgallery-manager)](https://github.com/ZeroMarker/psgallery-manager/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/PsGalleryManager.svg)](https://www.powershellgallery.com/packages/PsGalleryManager)

A PowerShell module for managing modules from the PowerShell Gallery with manifest-based environment synchronization.

## Features

- Search modules in the PowerShell Gallery with tag filtering
- Install, update, and remove modules with version control
- View installed modules with update availability check
- Export and sync module environments via JSON manifests
- Cross-platform support (Windows, Linux, macOS)

## Installation

### From PowerShell Gallery

```powershell
Install-Module -Name PsGalleryManager -Scope CurrentUser
```

### From Source

```powershell
git clone https://github.com/ZeroMarker/psgallery-manager.git
Import-Module ./psgallery-manager/PsGalleryManager.psd1
```

## Quick Start

```powershell
# Search for modules
Search-PsGalleryModule -Name 'PSReadLine'
Search-PsGalleryModule -Name 'git' -Tag 'git' -MaxResults 5

# Install a module
Install-PsGalleryModule -Name 'PSReadLine'
Install-PsGalleryModule -Name 'PSReadLine' -RequiredVersion '2.3.4' -PassThru

# Update modules
Update-PsGalleryModule -Name 'PSReadLine'
Update-PsGalleryModule  # Update all installed modules

# View installed modules
Get-InstalledModuleInfo
Get-InstalledModuleInfo -Outdated  # Only show modules with updates available

# Get module details from Gallery
Get-PsGalleryModule -Name 'PSReadLine'

# Remove a module
Remove-PsGalleryModule -Name 'PSReadLine'
```

## Environment Sync

Manage your module environment across machines using JSON manifests:

```powershell
# Export current environment
Export-ModuleManifest -Path './my-modules.json' -IncludeVersions

# Sync from manifest on another machine
Sync-PsGalleryModules -Path './my-modules.json'

# Preview changes without applying
Sync-PsGalleryModules -Path './my-modules.json' -DryRun

# Sync and remove modules not in the manifest
Sync-PsGalleryModules -Path './my-modules.json' -RemoveUnlisted
```

### Manifest Format

```json
{
    "modules": [
        { "name": "PSReadLine" },
        { "name": "posh-git", "version": "2.10.0" },
        { "name": "Terminal-Icons" }
    ]
}
```

See [examples/modules.json](examples/modules.json) for a complete example.

## Commands

| Command | Description |
|---------|-------------|
| `Search-PsGalleryModule` | Search for modules in the PowerShell Gallery |
| `Get-PsGalleryModule` | Get detailed module info from the Gallery |
| `Install-PsGalleryModule` | Install a module from the Gallery |
| `Update-PsGalleryModule` | Update installed modules |
| `Remove-PsGalleryModule` | Remove an installed module |
| `Get-InstalledModuleInfo` | List installed modules with details |
| `Export-ModuleManifest` | Export installed modules to a JSON manifest |
| `Sync-PsGalleryModules` | Sync modules from a JSON manifest |

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
