param(
    [Parameter(Mandatory)]
    [ValidateSet('Major', 'Minor', 'Patch')]
    [string]$Type,

    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = $PSScriptRoot

# Read current version from manifest
$manifestPath = Join-Path $ProjectRoot 'PsGalleryManager.psd1'
$manifestContent = Get-Content $manifestPath -Raw

if ($manifestContent -match "ModuleVersion\s*=\s*'(\d+)\.(\d+)\.(\d+)'") {
    $major = [int]$Matches[1]
    $minor = [int]$Matches[2]
    $patch = [int]$Matches[3]
}
else {
    throw "Could not find version in manifest."
}

$CurrentVersion = "$major.$minor.$patch"

switch ($Type) {
    'Major' { $major++; $minor = 0; $patch = 0 }
    'Minor' { $minor++; $patch = 0 }
    'Patch' { $patch++ }
}

$NewVersion = "$major.$minor.$patch"

Write-Host "Version: $CurrentVersion -> $NewVersion" -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "[DryRun] No changes made." -ForegroundColor Yellow
    exit 0
}

# Update manifest
$manifestContent = $manifestContent -replace "ModuleVersion\s*=\s*'[^']*'", "ModuleVersion     = '$NewVersion'"
Set-Content $manifestPath -Value $manifestContent -NoNewline
Write-Host "Updated: PsGalleryManager.psd1" -ForegroundColor Green

# Add Unreleased section to CHANGELOG
$changelogPath = Join-Path $ProjectRoot 'CHANGELOG.md'
$changelog = Get-Content $changelogPath -Raw

$today = Get-Date -Format 'yyyy-MM-dd'
$newSection = @"
## [Unreleased]

## [$NewVersion] - $today

"@

$changelog = $changelog -replace '## \[Unreleased\]', $newSection
Set-Content $changelogPath -Value $changelog -NoNewline
Write-Host "Updated: CHANGELOG.md" -ForegroundColor Green

# Git operations
git add $manifestPath $changelogPath
git commit -m "chore: bump version to $NewVersion"
git tag -a "v$NewVersion" -m "v$NewVersion"
Write-Host "`nTagged: v$NewVersion" -ForegroundColor Green
Write-Host "Run: git push && git push origin v$NewVersion" -ForegroundColor Yellow
