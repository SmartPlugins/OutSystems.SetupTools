function New-OSPlatformServiceCenterUser
{
    <#
    .SYNOPSIS


    .DESCRIPTION


    .NOTES

    #>

    [OutputType('OutSystems.PlatformServices.CS_ServiceCenterUserInfo')]
    [OutputType('Outsystems.SetupTools.User', ParameterSetName = "PassThru")]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [Alias('Host', 'Environment', 'ServiceCenterHost')]
        [string]$ServiceCenter = '127.0.0.1',

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Credential()]
        [System.Management.Automation.PSCredential]$Credential = $OSSCCred,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Username,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [securestring]$Password,

        [Parameter()]
        [string]$Email,

        [Parameter()]
        [string]$MobilePhone,

        [Parameter(ParameterSetName = 'PassThru')]
        [switch]$PassThru
    )

    begin
    {
        LogMessage -Function $($MyInvocation.Mycommand) -Phase 0 -Stream 0 -Message "Starting"
        SendFunctionStartEvent -InvocationInfo $MyInvocation
    }

    process
    {
        #region Check if users are managed by Lifetime
        # TO BE DONE!!
        #endregion

        #region Check if user exists
        LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 0 -Message "Checking if username $Username already exists"
        try
        {
            if (UserMgmt_GetSCUserByUsername -SCHost $SCHost -Credential $Credential -Username $Username)
            {
                LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 3 -Message "Username $Username already exists"
                WriteNonTerminalError -Message "Username $Username already exists"

                return $null
            }
        }
        catch
        {
            LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 3 -Message "Error getting information from service center $ServiceCenter" -Exception $_.Exception
            WriteNonTerminalError -Message "Error getting information from service center $ServiceCenter"

            return $null
        }
        #endregion

        #region Create user
        LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 0 -Message "Creating user $Username"
        try
        {
            $scUser = UserMgmt_SetSCUser -SCHost $ServiceCenter -Credential $Credential -Name $Name -Username $Username -Password $Password -Email $Email -Mobile $MobilePhone -IsActive $true
        }
        catch
        {
            LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 3 -Message "Error creating user $Username" -Exception $_.Exception
            WriteNonTerminalError -Message "Error creating user $Username"

            return $null
        }
        LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 0 -Message "Username $Username created successfully"
        #endregion

        # If PassThru, we create a custom and add the service center and the credentials to the object to be used in another piped functions
        if ($PassThru.IsPresent)
        {
            return [pscustomobject]@{
                PSTypeName    = 'Outsystems.SetupTools.User'
                ServiceCenter = $ServiceCenter
                Credential    = $Credential
                User          = $scUser
            }
        }
        else
        {
            return $scUser
        }
    }

    end
    {
        SendFunctionEndEvent -InvocationInfo $MyInvocation
        LogMessage -Function $($MyInvocation.Mycommand) -Phase 2 -Stream 0 -Message "Ending"
    }
}
