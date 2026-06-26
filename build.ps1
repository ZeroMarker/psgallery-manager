# Build script for PsGalleryManager

param(
    [ValidateSet('Test', 'Lint', 'Build', 'All')]
    [string]$Task = 'All'
)

$ErrorActionPreference = 'Stop'
$ModulePath = $PSScriptRoot

function Invoke-Tests {
    Write-Host "Running Pester tests..." -ForegroundColor Cyan
    $config = New-PesterConfiguration
    $config.Run.Path = Join-Path $ModulePath 'Tests'
    $config.Output.Verbosity = 'Detailed'
    Invoke-Pester -Configuration $config
}

function Invoke-Lint {
    Write-Host "Running PSScriptAnalyzer..." -ForegroundColor Cyan
    $results = Invoke-ScriptAnalyzer -Path $ModulePath -Recurse -ExcludeRule PSUseShouldProcessForStateChangeFunctions
    if ($results) {
        $results | Format-Table -AutoSize
        throw "PSScriptAnalyzer found $($results.Count) issue(s)."
    }
    Write-Host "No issues found." -ForegroundColor Green
}

function Invoke-Build {
    Write-Host "Building module package..." -ForegroundColor Cyan
    $outDir = Join-Path $ModulePath 'out'
    if (Test-Path $outDir) { Remove-Item $outDir -Recurse -Force }
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null

    $stagingDir = Join-Path $outDir 'PsGalleryManager'
    New-Item -ItemType Directory -Path $stagingDir -Force | Out-Null

    Copy-Item -Path (Join-Path $ModulePath '*.ps1'), (Join-Path $ModulePath '*.psd1'), (Join-Path $ModulePath '*.psm1') -Destination $stagingDir
    Copy-Item -Path (Join-Path $ModulePath 'Public'), (Join-Path $ModulePath 'Private') -Destination $stagingDir -Recurse -ErrorAction SilentlyContinue

    $manifest = Import-PowerShellDataFile (Join-Path $ModulePath 'PsGalleryManager.psd1')
    $version = $manifest.ModuleVersion
    $zipPath = Join-Path $outDir "PsGalleryManager-$version.zip"
    Compress-Archive -Path "$stagingDir/*" -DestinationPath $zipPath

    Write-Host "Built: $zipPath" -ForegroundColor Green
}

switch ($Task) {
    'Test'  { Invoke-Tests }
    'Lint'  { Invoke-Lint }
    'Build' { Invoke-Build }
    'All'   {
        Invoke-Lint
        Invoke-Tests
        Invoke-Build
    }
}
