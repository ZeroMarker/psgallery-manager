$PublicFunctions = @(Get-ChildItem -Path "$PSScriptRoot/Public/*.ps1" -ErrorAction SilentlyContinue)
$PrivateFunctions = @(Get-ChildItem -Path "$PSScriptRoot/Private/*.ps1" -ErrorAction SilentlyContinue)

foreach ($Function in @($PublicFunctions + $PrivateFunctions)) {
    try {
        . $Function.FullName
    }
    catch {
        Write-Error "Failed to import function $($Function.FullName): $_"
    }
}

Export-ModuleMember -Function $PublicFunctions.BaseName
