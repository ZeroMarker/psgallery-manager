function Get-PsGalleryModule {
    <#
    .SYNOPSIS
        Get module details from the PowerShell Gallery.
    .DESCRIPTION
        Retrieves detailed information about a specific module from the PowerShell Gallery.
    .PARAMETER Name
        The name of the module to look up.
    .PARAMETER Version
        Retrieve a specific version of the module.
    .EXAMPLE
        Get-PsGalleryModule -Name 'PSReadLine'
    .OUTPUTS
        PSCustomObject - Module information from the PowerShell Gallery.
    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Version
    )

    process {
        $Params = @{
            Name       = $Name
            Repository = 'PSGallery'
        }
        if ($Version) {
            $Params['RequiredVersion'] = $Version
        }

        try {
            Find-Module @Params -ErrorAction Stop
        }
        catch {
            Write-Error "Module '$Name' not found in PowerShell Gallery: $_"
        }
    }
}
