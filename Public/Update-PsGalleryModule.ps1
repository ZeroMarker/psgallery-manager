function Update-PsGalleryModule {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Position = 0)]
        [string[]]$Name,

        [Parameter()]
        [switch]$Force
    )

    if ($Name) {
        foreach ($ModuleName in $Name) {
            if ($PSCmdlet.ShouldProcess($ModuleName, "Update module")) {
                Update-Module -Name $ModuleName -Force:$Force -ErrorAction SilentlyContinue
            }
        }
    }
    else {
        $Installed = Get-InstalledModule
        foreach ($Module in $Installed) {
            if ($PSCmdlet.ShouldProcess($Module.Name, "Update module")) {
                Update-Module -Name $Module.Name -Force:$Force -ErrorAction SilentlyContinue
            }
        }
    }
}
