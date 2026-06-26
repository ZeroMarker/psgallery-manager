function Search-PsGalleryModule {
    <#
    .SYNOPSIS
        Search for modules in the PowerShell Gallery.
    .DESCRIPTION
        Searches the PowerShell Gallery for modules matching the specified name pattern.
        Supports wildcard matching and result filtering.
    .PARAMETER Name
        The name or partial name of the module to search for.
    .PARAMETER MaxResults
        Maximum number of results to return. Default is 20.
    .PARAMETER Tag
        Filter results by tag.
    .EXAMPLE
        Search-PsGalleryModule -Name 'PSReadLine'
    .EXAMPLE
        Search-PsGalleryModule -Name 'git' -Tag 'git' -MaxResults 5
    .OUTPUTS
        PSCustomObject[] - Module information from the PowerShell Gallery.
    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [ValidateRange(1, 100)]
        [int]$MaxResults = 20,

        [Parameter()]
        [string]$Tag
    )

    process {
        $Params = @{
            Name       = "*$Name*"
            Repository = 'PSGallery'
        }
        if ($Tag) {
            $Params['Tag'] = $Tag
        }

        try {
            Find-Module @Params | Select-Object -First $MaxResults
        }
        catch {
            Write-Error "Failed to search for module '$Name': $_"
        }
    }
}
