function Get-BasicAuthForHeader {
    <#
    .SYNOPSIS
        Creates the content of the value for the 'Authorization' Property.
    .COMPONENT
        API
    .EXAMPLE
        Get-BasicAuthForHeader -username 'username' -password (ConvertTo-SecureString "password" -AsPlainText -Force)

        returns "Basic dXNlcm5hbWU6cGFzc3dvcmQ="
        
    .EXAMPLE
        $PSDefaultParameterValues = @{
            "Invoke-RestMethod:Headers"= @{
                'Authorization' = Get-BasicAuthForHeader -username 'username' -password (ConvertTo-SecureString "password" -AsPlainText -Force)
            }
        }
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$username,
        [Parameter(Mandatory=$true)][SecureString]$password
    )
    process {
        return "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$username`:$((New-Object System.Management.Automation.PSCredential 0, $password).GetNetworkCredential().Password)")))"
    }
}
