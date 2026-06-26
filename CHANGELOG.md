# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-06-26

### Added
- `Search-PsGalleryModule` - Search modules with tag filtering support
- `Install-PsGalleryModule` - Install modules with version control and `-PassThru`
- `Update-PsGalleryModule` - Update modules with `-PassThru` support
- `Remove-PsGalleryModule` - Remove installed modules
- `Get-PsGalleryModule` - Get module details from the Gallery with version lookup
- `Get-InstalledModuleInfo` - List installed modules with `-Outdated` filter
- `Export-ModuleManifest` - Export installed modules to a JSON manifest
- `Sync-PsGalleryModules` - Sync modules from manifest with `-DryRun` and `-RemoveUnlisted`
- Pipeline input support for all commands
- Full comment-based help for all functions
- PSScriptAnalyzer CI workflow
- Pester test suite with cross-platform CI (Windows, Linux, macOS)
- Automated release and PSGallery publish workflows
- Issue templates (bug report, feature request)
- CONTRIBUTING guide

### Changed
- Improved error handling across all commands
- Added `ConfirmImpact` levels for destructive operations
- Added `-PassThru` parameters to install/update commands
- Updated manifest with proper GUID, copyright, and metadata

## [0.1.0] - 2026-06-26

### Added
- Initial project scaffold
- Basic module structure with Public/Private directories
- README, LICENSE, .gitignore
