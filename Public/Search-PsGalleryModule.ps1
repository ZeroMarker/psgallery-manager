function Search-PsGalleryModule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [Parameter()]
        [ValidateRange(1, 100)]
        [int]$MaxResults = 20
    )

    Find-Module -Name "*$Name*" -Repository PSGallery | Select-Object -First $MaxResults
}
