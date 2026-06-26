function Remove-PsGalleryModule {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string[]]$Name,

        [Parameter()]
        [switch]$Force
    )

    foreach ($ModuleName in $Name) {
        if ($PSCmdlet.ShouldProcess($ModuleName, "Uninstall module")) {
            Uninstall-Module -Name $ModuleName -Force:$Force -ErrorAction Stop
            Write-Verbose "Module '$ModuleName' removed successfully."
        }
    }
}
