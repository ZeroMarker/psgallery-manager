Describe 'PsGalleryManager Module' {
    Context 'Module Import' {
        It 'Should import without errors' {
            { Import-Module "$PSScriptRoot/../PsGalleryManager.psd1" -Force } | Should -Not -Throw
        }

        It 'Should export expected functions' {
            Import-Module "$PSScriptRoot/../PsGalleryManager.psd1" -Force
            $Commands = Get-Command -Module PsGalleryManager
            $Commands.Name | Should -Contain 'Search-PsGalleryModule'
            $Commands.Name | Should -Contain 'Install-PsGalleryModule'
            $Commands.Name | Should -Contain 'Update-PsGalleryModule'
            $Commands.Name | Should -Contain 'Remove-PsGalleryModule'
            $Commands.Name | Should -Contain 'Get-PsGalleryModule'
            $Commands.Name | Should -Contain 'Get-InstalledModuleInfo'
            $Commands.Name | Should -Contain 'Sync-PsGalleryModules'
        }
    }
}
