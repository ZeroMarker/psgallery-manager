Describe 'PsGalleryManager Module' {

    BeforeAll {
        $ModulePath = "$PSScriptRoot/../PsGalleryManager.psd1"
    }

    Context 'Module Import' {
        It 'Should import without errors' {
            { Import-Module $ModulePath -Force -ErrorAction Stop } | Should -Not -Throw
        }

        It 'Should export expected functions' {
            Import-Module $ModulePath -Force
            $ExpectedFunctions = @(
                'Export-ModuleManifest',
                'Get-InstalledModuleInfo',
                'Get-PsGalleryModule',
                'Install-PsGalleryModule',
                'Remove-PsGalleryModule',
                'Search-PsGalleryModule',
                'Sync-PsGalleryModules',
                'Update-PsGalleryModule'
            )
            $Commands = (Get-Command -Module PsGalleryManager).Name
            foreach ($Func in $ExpectedFunctions) {
                $Commands | Should -Contain $Func
            }
        }

        It 'Should have a valid module manifest' {
            $manifest = Test-ModuleManifest -Path $ModulePath -ErrorAction Stop
            $manifest | Should -Not -BeNullOrEmpty
            $manifest.Name | Should -Be 'PsGalleryManager'
        }
    }

    Context 'Function Parameters' {
        BeforeAll {
            Import-Module $ModulePath -Force
        }

        It 'Search-PsGalleryModule should have Name parameter' {
            $cmd = Get-Command Search-PsGalleryModule
            $cmd.Parameters['Name'] | Should -Not -BeNullOrEmpty
            $cmd.Parameters['Name'].Attributes.Mandatory | Should -Contain $true
        }

        It 'Install-PsGalleryModule should have Scope parameter with validation' {
            $cmd = Get-Command Install-PsGalleryModule
            $validateSet = $cmd.Parameters['Scope'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $validateSet.ValidValues | Should -Contain 'CurrentUser'
            $validateSet.ValidValues | Should -Contain 'AllUsers'
        }

        It 'Sync-PsGalleryModules should have DryRun switch' {
            $cmd = Get-Command Sync-PsGalleryModules
            $cmd.Parameters['DryRun'] | Should -Not -BeNullOrEmpty
            $cmd.Parameters['DryRun'].ParameterType.Name | Should -Be 'SwitchParameter'
        }

        It 'Export-ModuleManifest should have IncludeVersions switch' {
            $cmd = Get-Command Export-ModuleManifest
            $cmd.Parameters['IncludeVersions'] | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Help Documentation' {
        BeforeAll {
            Import-Module $ModulePath -Force
        }

        It 'All public functions should have synopsis' {
            $commands = Get-Command -Module PsGalleryManager
            foreach ($cmd in $commands) {
                $help = Get-Help $cmd.Name
                $help.Synopsis | Should -Not -BeNullOrEmpty -Because "$($cmd.Name) should have a synopsis"
            }
        }

        It 'All public functions should have description' {
            $commands = Get-Command -Module PsGalleryManager
            foreach ($cmd in $commands) {
                $help = Get-Help $cmd.Name
                $help.Description | Should -Not -BeNullOrEmpty -Because "$($cmd.Name) should have a description"
            }
        }
    }
}
