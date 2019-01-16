function UserMgmt_SetSCUser([string]$SCHost, [pscredential]$Credential, [string]$Name, [string]$Username, [securestring]$Password, [string]$Email, [string]$Mobile, [bool]$IsActive)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Changing/Adding username $Username"

    $SCAdminUser = $Credential.UserName
    $SCAdminPass = $Credential.GetNetworkCredential().Password

    $null = SCWS_Server_CreateOrUpdateServiceCenterUser -SCHost $SCHost -SCUser $SCAdminUser -SCPass $SCAdminPass -Name $Name -Username $Username -Password $Password -Email $Email -MobilePhone $Mobile -IsActive $IsActive

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Username $Username added or changed"

    $scUser = UserMgmt_GetSCUserByUsername -SCHost $SCHost -Credential $Credential -Username $Username -OnlyActive $IsActive

    return $scUser
}

function UserMgmt_GetSCUsers([string]$SCHost, [pscredential]$Credential, [bool]$OnlyActive)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting users from service center $SCHost"

    $SCAdminUser = $Credential.UserName
    $SCAdminPass = $Credential.GetNetworkCredential().Password

    $scUsers = SCWS_Server_GetServiceCenterUsers -SCHost $SCHost -SCUser $SCAdminUser -SCPass $SCAdminPass -OnlyActive $OnlyActive

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning $($scUsers.Count) users"

    return $scUsers
}

function UserMgmt_GetSCUserByUsername([string]$SCHost, [pscredential]$Credential, [string]$Username, [bool]$OnlyActive)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting user $Username"

    $scUser = $(UserMgmt_GetSCUsers -SCHost $SCHost -Credential $Credential -OnlyActive $OnlyActive) | Where-Object -FilterScript {$_.User.Username -eq $Username}

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning user $Username"

    return $scUser
}

