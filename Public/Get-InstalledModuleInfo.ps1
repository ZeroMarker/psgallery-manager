function Get-InstalledModuleInfo {
    <#
    .SYNOPSIS
        List installed modules with detailed information.
    .DESCRIPTION
        Displays detailed information about installed modules including version,
        install date, and repository source.
    .PARAMETER Name
        The name of a specific module to query. If omitted, all installed modules are listed.
    .PARAMETER Outdated
        Only show modules that have updates available in the Gallery.
    .EXAMPLE
        Get-InstalledModuleInfo
    .EXAMPLE
        Get-InstalledModuleInfo -Name 'PSReadLine'
    .EXAMPLE
        Get-InstalledModuleInfo -Outdated
    .OUTPUTS
        PSCustomObject[] - Module information objects.
    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param(
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,

        [Parameter()]
        [switch]$Outdated
    )

    process {
        try {
            if ($Name) {
                $Modules = Get-InstalledModule -Name $Name -ErrorAction Stop
            }
            else {
                $Modules = Get-InstalledModule -ErrorAction Stop
            }

            foreach ($Module in $Modules) {
                $Info = [PSCustomObject]@{
                    Name          = $Module.Name
                    Version       = $Module.Version
                    InstalledDate = $Module.InstalledDate
                    UpdatedDate   = $Module.UpdatedDate
                    Repository    = $Module.Repository
                    InstalledLocation = $Module.InstalledLocation
                }

                if ($Outdated) {
                    try {
                        $Latest = Find-Module -Name $Module.Name -Repository PSGallery -ErrorAction SilentlyContinue
                        if ($Latest -and $Latest.Version -gt $Module.Version) {
                            $Info | Add-Member -NotePropertyName 'LatestVersion' -NotePropertyValue $Latest.Version
                            $Info
                        }
                    }
                    catch {
                        Write-Warning "Could not check latest version for '$($Module.Name)'."
                    }
                }
                else {
                    $Info
                }
            }
        }
        catch {
            Write-Error "Failed to retrieve module information: $_"
        }
    }
}
