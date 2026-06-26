function Install-PsGalleryModule {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [Parameter()]
        [string]$RequiredVersion,

        [Parameter()]
        [ValidateSet('CurrentUser', 'AllUsers')]
        [string]$Scope = 'CurrentUser',

        [Parameter()]
        [switch]$Force
    )

    $Params = @{
        Name      = $Name
        Repository = 'PSGallery'
        Scope     = $Scope
        Force     = $Force
    }

    if ($RequiredVersion) {
        $Params['RequiredVersion'] = $RequiredVersion
    }

    if ($PSCmdlet.ShouldProcess($Name, "Install module")) {
        Install-Module @Params
        Get-InstalledModule -Name $Name -ErrorAction SilentlyContinue
    }
}
