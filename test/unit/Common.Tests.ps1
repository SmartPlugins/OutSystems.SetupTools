# This should be changed to import the OS DLLs directly and not importing the module
Get-Module Outsystems.SetupTools | Remove-Module -Force
Import-Module $PSScriptRoot\..\..\src\Outsystems.SetupTools -Force -ArgumentList $false, '', '', $false

. $PSScriptRoot\..\..\src\Outsystems.SetupTools\Lib\Common.ps1

Describe 'GetHashedPassword Tests' {
    Context 'Normal' {
        It 'Checks if returns a string' {
            GetHashedPassword -Password "MyPass" | Should BeLike "#*"
        }
    }
}
