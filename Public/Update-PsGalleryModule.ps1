function Update-PsGalleryModule {
    <#
    .SYNOPSIS
        Update installed modules from the PowerShell Gallery.
    .DESCRIPTION
        Updates one or more installed modules to their latest versions from the PowerShell Gallery.
        If no name is specified, all installed modules are updated.
    .PARAMETER Name
        The name(s) of the module(s) to update. If omitted, all modules are updated.
    .PARAMETER Force
        Force update without prompting.
    .PARAMETER PassThru
        Return the updated module objects.
    .EXAMPLE
        Update-PsGalleryModule -Name 'PSReadLine'
    .EXAMPLE
        Update-PsGalleryModule
    .OUTPUTS
        Microsoft.PowerShell.Commands.PSRepositoryItemInfo[] - When -PassThru is specified.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$Name,

        [Parameter()]
        [switch]$Force,

        [Parameter()]
        [switch]$PassThru
    )

    process {
        if ($Name) {
            $ModulesToUpdate = $Name
        }
        else {
            try {
                $ModulesToUpdate = (Get-InstalledModule -ErrorAction Stop).Name
            }
            catch {
                Write-Error "Failed to retrieve installed modules: $_"
                return
            }
        }

        foreach ($ModuleName in $ModulesToUpdate) {
            if ($PSCmdlet.ShouldProcess($ModuleName, "Update module")) {
                try {
                    Update-Module -Name $ModuleName -Force:$Force -ErrorAction Stop
                    Write-Verbose "Module '$ModuleName' updated successfully."
                    if ($PassThru) {
                        Get-InstalledModule -Name $ModuleName -ErrorAction SilentlyContinue
                    }
                }
                catch {
                    Write-Warning "Failed to update module '$ModuleName': $_"
                }
            }
        }
    }
}
