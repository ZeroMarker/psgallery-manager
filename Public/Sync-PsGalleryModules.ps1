function Sync-PsGalleryModules {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateScript({ Test-Path $_ })]
        [string]$ManifestPath,

        [Parameter()]
        [ValidateSet('CurrentUser', 'AllUsers')]
        [string]$Scope = 'CurrentUser',

        [Parameter()]
        [switch]$RemoveUnlisted
    )

    $Manifest = Get-Content -Path $ManifestPath -Raw | ConvertFrom-Json

    $DesiredModules = $Manifest.modules

    foreach ($Module in $DesiredModules) {
        $Installed = Get-InstalledModule -Name $Module.name -ErrorAction SilentlyContinue

        if (-not $Installed) {
            if ($PSCmdlet.ShouldProcess($Module.name, "Install module")) {
                $Params = @{
                    Name       = $Module.name
                    Scope      = $Scope
                    Force      = $true
                    ErrorAction = 'SilentlyContinue'
                }
                if ($Module.version) {
                    $Params['RequiredVersion'] = $Module.version
                }
                Install-Module @Params
                Write-Verbose "Installed: $($Module.name)"
            }
        }
        elseif ($Module.version -and $Installed.Version -ne $Module.version) {
            if ($PSCmdlet.ShouldProcess($Module.name, "Update to version $($Module.version)")) {
                Update-Module -Name $Module.name -Force -ErrorAction SilentlyContinue
                Write-Verbose "Updated: $($Module.name)"
            }
        }
    }

    if ($RemoveUnlisted) {
        $Installed = Get-InstalledModule
        foreach ($Module in $Installed) {
            if ($Module.Name -notin $DesiredModules.name) {
                if ($PSCmdlet.ShouldProcess($Module.Name, "Remove unlisted module")) {
                    Uninstall-Module -Name $Module.Name -Force -ErrorAction SilentlyContinue
                    Write-Verbose "Removed unlisted: $($Module.Name)"
                }
            }
        }
    }
}
