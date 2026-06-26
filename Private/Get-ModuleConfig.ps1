function Get-ModuleConfig {
    [CmdletBinding()]
    param()

    $ConfigPath = Join-Path $env:USERPROFILE '.psgallery-manager.json'

    if (Test-Path $ConfigPath) {
        try {
            Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to parse config file at '$ConfigPath'. Using defaults."
            $null
        }
    }
}
