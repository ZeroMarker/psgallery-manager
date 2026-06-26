function Export-ModuleManifest {
    <#
    .SYNOPSIS
        Export installed modules to a JSON manifest file.
    .DESCRIPTION
        Creates a JSON manifest of currently installed modules that can be used
        with Sync-PsGalleryModules to replicate the environment.
    .PARAMETER Path
        The output path for the manifest file.
    .PARAMETER IncludeVersions
        Include specific versions in the manifest.
    .EXAMPLE
        Export-ModuleManifest -Path './my-modules.json'
    .EXAMPLE
        Export-ModuleManifest -Path './my-modules.json' -IncludeVersions
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Path,

        [Parameter()]
        [switch]$IncludeVersions
    )

    process {
        try {
            $Modules = Get-InstalledModule -ErrorAction Stop

            $Manifest = @{
                exportedAt = (Get-Date -Format 'o')
                modules    = @(
                    foreach ($Module in $Modules) {
                        $Entry = @{ name = $Module.Name }
                        if ($IncludeVersions) {
                            $Entry['version'] = $Module.Version.ToString()
                        }
                        $Entry
                    }
                )
            }

            if ($PSCmdlet.ShouldProcess($Path, "Export module manifest")) {
                $Manifest | ConvertTo-Json -Depth 10 | Set-Content -Path $Path -Encoding UTF8
                Write-Host "Exported $($Modules.Count) modules to '$Path'" -ForegroundColor Green
            }
        }
        catch {
            Write-Error "Failed to export manifest: $_"
        }
    }
}
