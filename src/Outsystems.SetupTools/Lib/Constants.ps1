# Outsystems services
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSServices = @(
    "OutSystems Log Service",
    "OutSystems Deployment Controller Service",
    "OutSystems Deployment Service",
    "OutSystems Scheduler Service",
    "OutSystems SMS Connector Service"
)

# Outsystems base windows features
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSWindowsFeaturesBase = @(
    "Web-Default-Doc", "Web-Dir-Browsing", "Web-Http-Errors", "Web-Static-Content",
    "Web-Http-Logging", "Web-Request-Monitor",
    "Web-Stat-Compression", "Web-Dyn-Compression",
    "Web-Filtering", "Web-Windows-Auth", `
    "Web-Net-Ext45", "Web-Asp-Net45", "Web-ISAPI-Ext", "Web-ISAPI-Filter",
    "Web-Metabase",
    "WAS-Config-APIs", "WAS-Process-Model"
)

# Hardware requirements
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS10ReqsMinCores = 2
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS10ReqsMinRAMGB = 4
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS11ReqsMinCores = 2
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS11ReqsMinRAMGB = 4

# Software and operating system requirements
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS10ReqsMinOSVersion = "6.2.0.0"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS11ReqsMinOSVersion = "10.0.14393"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSReqsMinOSProductType = 2
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS10ReqsMinDotNetVersion = "394254"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS11ReqsMinDotNetVersion = "461808"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OS11ReqsMinDotNetCoreVersion = "2.0.7"

# Windows event log configs
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSWinEventLogSize = 20480KB
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSWinEventLogOverflowAction = "OverwriteAsNeeded"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSWinEventLogName = @(
    "Security",
    "Application",
    "System"
)

# Default install directories
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSDefaultInstallDir = "$Env:ProgramFiles\OutSystems"

# Default Service Center credentials
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSSCUser = "admin"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSSCPass = "admin"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSSCCred = New-Object System.Management.Automation.PSCredential ($OSSCUser, $(ConvertTo-SecureString $OSSCPass -AsPlainText -Force))

# Sources download URLs
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSRepoURL = "https://myfilerepo.blob.core.windows.net/sources"
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSRepoURLDotNET = 'https://download.microsoft.com/download/6/E/4/6E48E8AB-DC00-419E-9704-06DD46E5F81D/NDP472-KB4054530-x86-x64-AllOS-ENU.exe'
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSRepoURLBuildTools = 'https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe'
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSRepoURLDotNETCore = 'https://aka.ms/dotnetcore-2-windowshosting'

# Database default timeout
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSDBTimeout = "60"

# Log related
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSLogFile = ""
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSLogDebug = $false

# RabbitMQ related. installDir is set on the Install-RabbitMQ cmdLet cause it depends on where the plaform is installed
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSRabbitMQBaseDir = "$ENV:ALLUSERSPROFILE\RabbitMQ"

# Telemetry
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSTelAppInsightsKeys = @('91943ce0-af45-4b7c-a40d-0018e4072e8a')
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSTelTier = 'Standard'
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSTelEnabled = $true
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSTelSessionId = ''
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSTelOperationId = ''

# AzStorage
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSAzStorageAccountName = 'myfilerepo'
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSAzStorageSASToken = 'nAFk4sFRvsisvgwfijMpi67fy6ZAw8yfPvJXeiqOLUc%3D'
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSAzStorageContainer = 'sources'


# IIS configuration
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$OSIISConfig = @(
    @{
        'PoolName' = 'OutSystemsApplications';
        'MemoryPercentage' = 60;
        'Match' = @('*')
    },
    @{
        'PoolName' = 'ServiceCenterAppPool';
        'MemoryPercentage' = 100;
        'Match' = @('/ServiceCenter')
    },
    @{
        'PoolName' = 'LifeTimeAppPool';
        'MemoryPercentage' = 60;
        'Match' = @('/LT*','/lifet*','/LifeT*','PerformanceMonitor')
    }
)
