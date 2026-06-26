# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.2] - 2026-06-26

### Fixed
- Add `PSUseSingularNouns` to PSScriptAnalyzer exclusions

## [1.0.1] - 2026-06-26

### Fixed
- Replace `Write-Host` with `Write-Information` in module functions (`Sync-PsGalleryModules`, `Export-ModuleManifest`)
- Fix `PSUseDeclaredVarsMoreThanAssignments` warning in test file variable scoping

## [1.0.0] - 2026-06-26

### Added
- `Search-PsGalleryModule` - Search modules with tag filtering support
- `Install-PsGalleryModule` - Install modules with version control, `-MinimumVersion`, `-PassThru`
- `Update-PsGalleryModule` - Update modules with `-PassThru` support
- `Remove-PsGalleryModule` - Remove installed modules
- `Get-PsGalleryModule` - Get module details from the Gallery with `-Version` lookup
- `Get-InstalledModuleInfo` - List installed modules with `-Outdated` filter
- `Export-ModuleManifest` - Export installed modules to a JSON manifest
- `Sync-PsGalleryModules` - Sync modules from manifest with `-DryRun` and `-RemoveUnlisted`
- Pipeline input support for all commands
- Full comment-based help (synopsis, description, parameters, examples) for all functions
- PSScriptAnalyzer CI workflow
- Pester test suite with cross-platform CI (Windows, Linux, macOS)
- Automated release and PSGallery publish workflows
- Issue templates (bug report, feature request)
- CONTRIBUTING guide

### Changed
- Improved error handling with `try/catch` across all commands
- Added `ConfirmImpact` levels for destructive operations
- Added `-PassThru` parameters to install/update commands
- Updated manifest with proper GUID, copyright, and metadata

## [0.1.0] - 2026-06-26

### Added
- Initial project scaffold
- Basic module structure with Public/Private directories
- README, LICENSE, .gitignore
