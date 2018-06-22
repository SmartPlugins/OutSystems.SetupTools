﻿# --- VARIABLES TO CHANGE ---- #

$LicensePath = "$PSScriptRoot\Sources\license.lic"
$InstallDir = "c:\OutSystems"

$ConfigToolArgs = @{
    InstallType         = 'Standalone'

    DBProvider          = 'SQLExpress'  # SQL (for standard), SQLExpress, Azure SQL
    DBAuth              = 'SQL'         # SQL or Windows

    DBServer            = '10.0.0.4'
    DBCatalog           = 'OS3'
    DBSAUser            = 'mysa'        # For Windows auth you need to add the domain like DOMAIN\Username
    DBSAPass            = 'secret25'

    DBSessionServer     = '10.0.0.4'
    DBSessionCatalog    = 'OS3'
    DBSessionUser       = 'OSSESSION'   # For Windows auth you need to add the domain like DOMAIN\Username
    DBSessionPass       = 'iPhone25'

    DBAdminUser         = 'OSADMIN'     # For Windows auth you need to add the domain like DOMAIN\Username
    DBAdminPass         = 'iPhone25'
    DBRuntimeUser       = 'OSRUNTIME'   # For Windows auth you need to add the domain like DOMAIN\Username
    DBRuntimePass       = 'iPhone25'
    DBLogUser           = 'OSRUNTIME'   # For Windows auth you need to add the domain like DOMAIN\Username
    DBLogPass           = 'iPhone25'
}

# --- VARIABLES TO CHANGE ---- #

# -- Import module from Powershell Gallery
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Remove-Module Outsystems.SetupTools -ErrorAction SilentlyContinue
Install-Module Outsystems.SetupTools -Force
Import-Module Outsystems.SetupTools

# -- Import module local
# Remove-Module Outsystems.SetupTools -ErrorAction SilentlyContinue
# Import-Module .\..\..\src\Outsystems.SetupTools

# -- Check HW and OS for compability
Test-OSPlatformHardwareReqs -Verbose
Test-OSPlatformSoftwareReqs -Verbose

# -- Install PreReqs
Install-OSPlatformServerPreReqs -Verbose

# -- Download and install OS Server and Dev environment from repo
Install-OSPlatformServer -Version 10.0.823.0 -InstallDir $InstallDir -Verbose
Install-OSDevEnvironment -Version 10.0.825.0 -InstallDir $InstallDir -Verbose

# -- Download and install OS Server and Dev environment from local source
# Install-OSPlatformServer -SourcePath "$PSScriptRoot\Sources" -Version 10.0.816.0 -Verbose
# Install-OSDevEnvironment -SourcePath "$PSScriptRoot\Sources" -Version 10.0.822.0 -Verbose

# -- Configure environment
Invoke-OSConfigurationTool -Verbose @ConfigToolArgs

# -- Install Service Center and SysComponents
Install-OSPlatformServiceCenter -Verbose
Install-OSPlatformSysComponents -Verbose

# -- Install license
Install-OSPlatformLicense -Path $LicensePath -Verbose

# -- Install Lifetime
Install-OSPlatformLifetime -Verbose

# -- System tunning
Set-OSPlatformPerformanceTunning -Verbose

# -- Security settings
Set-OSPlatformSecuritySettings -Verbose