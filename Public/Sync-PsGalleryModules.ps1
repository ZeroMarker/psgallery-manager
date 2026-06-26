function Sync-PsGalleryModules {
    <#
    .SYNOPSIS
        Sync modules from a JSON manifest file.
    .DESCRIPTION
        Installs, updates, or removes modules based on a JSON manifest file.
        Useful for synchronizing module environments across machines.
    .PARAMETER ManifestPath
        Path to the JSON manifest file containing the desired module list.
    .PARAMETER Scope
        The installation scope: CurrentUser or AllUsers. Default is CurrentUser.
    .PARAMETER RemoveUnlisted
        Remove installed modules that are not listed in the manifest.
    .PARAMETER DryRun
        Show what would be done without making changes.
    .EXAMPLE
        Sync-PsGalleryModules -ManifestPath './modules.json'
    .EXAMPLE
        Sync-PsGalleryModules -ManifestPath './modules.json' -RemoveUnlisted -DryRun
    .EXAMPLE
        Sync-PsGalleryModules -ManifestPath './modules.json' -Scope AllUsers
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateScript({
            if (-not (Test-Path $_)) {
                throw "Manifest file '$_' not found."
            }
            if ($_ -notmatch '\.json$') {
                throw "Manifest file must be a .json file."
            }
            $true
        })]
        [string]$ManifestPath,

        [Parameter()]
        [ValidateSet('CurrentUser', 'AllUsers')]
        [string]$Scope = 'CurrentUser',

        [Parameter()]
        [switch]$RemoveUnlisted,

        [Parameter()]
        [switch]$DryRun
    )

    try {
        $Manifest = Get-Content -Path $ManifestPath -Raw | ConvertFrom-Json -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to parse manifest file: $_"
        return
    }

    if (-not $Manifest.modules) {
        Write-Error "Manifest file does not contain a 'modules' property."
        return
    }

    $DesiredModules = $Manifest.modules
    $InstalledModules = Get-InstalledModule -ErrorAction SilentlyContinue

    $Results = @{
        Installed = @()
        Updated   = @()
        Removed   = @()
        Skipped   = @()
    }

    foreach ($Module in $DesiredModules) {
        $Installed = $InstalledModules | Where-Object Name -eq $Module.name

        if (-not $Installed) {
            if ($DryRun) {
                Write-Host "[DryRun] Would install: $($Module.name)" -ForegroundColor Yellow
                $Results.Installed += $Module.name
            }
            elseif ($PSCmdlet.ShouldProcess($Module.name, "Install module")) {
                $Params = @{
                    Name        = $Module.name
                    Scope       = $Scope
                    Force       = $true
                    ErrorAction = 'Stop'
                }
                if ($Module.version) {
                    $Params['RequiredVersion'] = $Module.version
                }
                try {
                    Install-Module @Params
                    Write-Host "Installed: $($Module.name)" -ForegroundColor Green
                    $Results.Installed += $Module.name
                }
                catch {
                    Write-Warning "Failed to install '$($Module.name)': $_"
                }
            }
        }
        elseif ($Module.version -and $Installed.Version -ne $Module.version) {
            if ($DryRun) {
                Write-Host "[DryRun] Would update: $($Module.name) ($($Installed.Version) -> $($Module.version))" -ForegroundColor Yellow
                $Results.Updated += $Module.name
            }
            elseif ($PSCmdlet.ShouldProcess($Module.name, "Update to version $($Module.version)")) {
                try {
                    Update-Module -Name $Module.name -Force -ErrorAction Stop
                    Write-Host "Updated: $($Module.name)" -ForegroundColor Green
                    $Results.Updated += $Module.name
                }
                catch {
                    Write-Warning "Failed to update '$($Module.name)': $_"
                }
            }
        }
        else {
            $Results.Skipped += $Module.name
        }
    }

    if ($RemoveUnlisted) {
        $Unlisted = $InstalledModules | Where-Object { $_.Name -notin $DesiredModules.name }
        foreach ($Module in $Unlisted) {
            if ($DryRun) {
                Write-Host "[DryRun] Would remove: $($Module.Name)" -ForegroundColor Yellow
                $Results.Removed += $Module.Name
            }
            elseif ($PSCmdlet.ShouldProcess($Module.Name, "Remove unlisted module")) {
                try {
                    Uninstall-Module -Name $Module.Name -Force -ErrorAction Stop
                    Write-Host "Removed: $($Module.Name)" -ForegroundColor Red
                    $Results.Removed += $Module.Name
                }
                catch {
                    Write-Warning "Failed to remove '$($Module.Name)': $_"
                }
            }
        }
    }

    if ($DryRun) {
        Write-Host "`n--- DryRun Summary ---" -ForegroundColor Cyan
    }
    else {
        Write-Host "`n--- Sync Summary ---" -ForegroundColor Cyan
    }
    Write-Host "Installed: $($Results.Installed.Count)" -ForegroundColor Green
    Write-Host "Updated:   $($Results.Updated.Count)" -ForegroundColor Green
    Write-Host "Removed:   $($Results.Removed.Count)" -ForegroundColor Red
    Write-Host "Skipped:   $($Results.Skipped.Count)" -ForegroundColor Gray
}
