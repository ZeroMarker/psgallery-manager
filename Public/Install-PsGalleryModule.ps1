function Install-PsGalleryModule {
    <#
    .SYNOPSIS
        Install a module from the PowerShell Gallery.
    .DESCRIPTION
        Installs a module from the PowerShell Gallery with version control and scope options.
    .PARAMETER Name
        The name of the module to install.
    .PARAMETER RequiredVersion
        The specific version to install.
    .PARAMETER MinimumVersion
        The minimum version to install.
    .PARAMETER Scope
        The installation scope: CurrentUser or AllUsers. Default is CurrentUser.
    .PARAMETER Force
        Force installation without prompting.
    .PARAMETER PassThru
        Return the installed module object.
    .EXAMPLE
        Install-PsGalleryModule -Name 'PSReadLine'
    .EXAMPLE
        Install-PsGalleryModule -Name 'PSReadLine' -RequiredVersion '2.3.4' -Scope AllUsers
    .OUTPUTS
        Microsoft.PowerShell.Commands.PSRepositoryItemInfo - When -PassThru is specified.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$RequiredVersion,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$MinimumVersion,

        [Parameter()]
        [ValidateSet('CurrentUser', 'AllUsers')]
        [string]$Scope = 'CurrentUser',

        [Parameter()]
        [switch]$Force,

        [Parameter()]
        [switch]$PassThru
    )

    process {
        foreach ($ModuleName in $Name) {
            $Params = @{
                Name       = $ModuleName
                Repository = 'PSGallery'
                Scope      = $Scope
                Force      = $Force
            }

            if ($RequiredVersion) {
                $Params['RequiredVersion'] = $RequiredVersion
            }
            if ($MinimumVersion) {
                $Params['MinimumVersion'] = $MinimumVersion
            }

            if ($PSCmdlet.ShouldProcess($ModuleName, "Install module")) {
                try {
                    Install-Module @Params -ErrorAction Stop
                    Write-Verbose "Module '$ModuleName' installed successfully."
                    if ($PassThru) {
                        Get-InstalledModule -Name $ModuleName -ErrorAction SilentlyContinue
                    }
                }
                catch {
                    Write-Error "Failed to install module '$ModuleName': $_"
                }
            }
        }
    }
}
