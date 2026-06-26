function Get-InstalledModuleInfo {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Name
    )

    if ($Name) {
        Get-InstalledModule -Name $Name -ErrorAction SilentlyContinue |
            Select-Object Name, Version, InstalledDate, UpdatedDate, Repository
    }
    else {
        Get-InstalledModule -ErrorAction SilentlyContinue |
            Select-Object Name, Version, InstalledDate, UpdatedDate, Repository |
            Sort-Object Name
    }
}
