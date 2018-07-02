﻿[CmdletBinding()]
Param()

# ------------- Outsystems configuration variables ------------------
# This can be FE for FrontEnd or LT for lifetime
$OSRole=""

$OSInstallDir="$Env:ProgramFiles\OutSystems"

$OSPlatformVersion='10.0.823.0'
$OSDevEnvironmentVersion='10.0.825.0'

# If you dont specify a license here, a trial license will be installed.
#$OSLicensePath="$PSScriptRoot"
$OSLicensePath=""

$OSLogPath="$Env:Windir\Temp\OutsystemsInstall"

$ConfigToolArgs = @{

    # If this is a frontend or you want to connect to an existing database environment specify the environment private key here.
    # In case this is a Farm deployment you should generate a new private key using the cmdlet New-OSPlatformPrivateKey
    PrivateKey          = ""

    # If this is a frontend specify here the controller IP address.
    Controller          = ""

    DBProvider          = "SQL"                 # This can be SQL, SQLExpress, AzureSQL
    DBAuth              = "SQL"                 # This can be SQL or Windows

    DBServer            = "<SQL server>"        # SQL server IP or hostname
    DBCatalog           = "outsystems"          # Platform catalog
    DBSAUser            = "sa"                  # User with dba permission on the database. If windows auth should be <DOMAIN\USER>
    DBSAPass            = "<sa password>"

    DBSessionServer     = "<SQL server>"        # SQL server IP or hostname for the session catalog
    DBSessionCatalog    = "osSession"           # Session catalog
    DBSessionUser       = "OSSTATE"             # Session DB User
    DBSessionPass       = "<OSSTATE pass>"      # Session DB Pass

    DBAdminUser         = "OSADMIN"             # Admin DB User
    DBAdminPass         = "<OSADMIN pass>"      # Admin DB Pass
    DBRuntimeUser       = "OSRUNTIME"           # Runtime DB User
    DBRuntimePass       = "<OSRUNTIME pass>"    # Runtime DB Pass
    DBLogUser           = "OSLOG"               # Log DB User
    DBLogPass           = "<OSLOG pass>"        # Log DB User
}

# ------------- Outsystems configuration variables ------------------

# -- Import module from Powershell Gallery
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Remove-Module Outsystems.SetupTools -ErrorAction SilentlyContinue
Install-Module Outsystems.SetupTools -Force
Import-Module Outsystems.SetupTools

# -- Import module local. If the systems doesnt have internet access
# Remove-Module Outsystems.SetupTools -ErrorAction SilentlyContinue
# Import-Module .\..\..\src\Outsystems.SetupTools

# -- Start logging
Start-Transcript -Path "$OSLogPath\$($MyInvocation.MyCommand.Name)-$(get-date -Format 'yyyyMMddHHmmss').log" -Force

# -- Check HW and OS for compability
Test-OSPlatformHardwareReqs -Verbose
Test-OSPlatformSoftwareReqs -Verbose

# -- Install PreReqs
Install-OSPlatformServerPreReqs -Verbose

# -- Download and install OS Server and Dev environment from repo
Install-OSPlatformServer -Version $OSPlatformVersion -InstallDir $OSInstallDir -Verbose

# If this is a frontend, wait for the controller to become available
If ($OSRole -eq "FE"){
    While ( -not $(Get-OSPlatformVersion -Host $ConfigToolArgs.Controller -ErrorAction SilentlyContinue) ) {
        Write-Output "Waiting for the controller $($ConfigToolArgs.Controller)"
        Start-Sleep -s 15
    }
}

# -- Run config tool
Invoke-OSConfigurationTool -Verbose @ConfigToolArgs

# -- If not a frontend install Service Center, SysComponents and license
If ($OSRole -ne "FE"){
    Install-OSPlatformServiceCenter
    Install-OSPlatformSysComponents
    Install-OSPlatformLicense -Path $OSLicensePath -Verbose
}

# -- Install Lifetime
If ($OSRole -eq "LT"){
    Install-OSPlatformLifetime -Verbose
}

# -- Install dev environment
Install-OSDevEnvironment -Version $OSDevEnvironmentVersion -InstallDir $OSInstallDir -Verbose

# -- System tunning
Set-OSPlatformPerformanceTunning -Verbose

# -- Security settings
Set-OSPlatformSecuritySettings -Verbose

# -- Stop logging
Stop-Transcript