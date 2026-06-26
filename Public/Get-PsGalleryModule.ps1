function Get-PsGalleryModule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name
    )

    Find-Module -Name $Name -Repository PSGallery -ErrorAction Stop
}
