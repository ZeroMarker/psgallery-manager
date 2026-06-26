function Remove-PsGalleryModule {
    <#
    .SYNOPSIS
        Remove an installed module.
    .DESCRIPTION
        Uninstalls one or more modules from the local system.
    .PARAMETER Name
        The name(s) of the module(s) to remove.
    .PARAMETER Force
        Force removal without prompting.
    .EXAMPLE
        Remove-PsGalleryModule -Name 'PSReadLine'
    .EXAMPLE
        Remove-PsGalleryModule -Name 'PSReadLine','Terminal-Icons' -Force
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name,

        [Parameter()]
        [switch]$Force
    )

    process {
        foreach ($ModuleName in $Name) {
            if ($PSCmdlet.ShouldProcess($ModuleName, "Uninstall module")) {
                try {
                    Uninstall-Module -Name $ModuleName -Force:$Force -ErrorAction Stop
                    Write-Verbose "Module '$ModuleName' removed successfully."
                }
                catch {
                    Write-Error "Failed to remove module '$ModuleName': $_"
                }
            }
        }
    }
}
