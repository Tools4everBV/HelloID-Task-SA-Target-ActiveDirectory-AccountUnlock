# HelloID-Task-SA-Target-ActiveDirectory-AccountUnlock
###################################################################
# Form mapping

$formObject = @{
    userPrincipalName = $form.userPrincipalName
}

try {
    Write-Information "Executing ActiveDirectory action: [UpdateAccount], Unlock for: [$($formObject.UserPrincipalName)]"
    Import-Module ActiveDirectory -ErrorAction Stop
    $adUser = Get-ADUser -Filter "userPrincipalName -eq '$($formObject.UserPrincipalName)'"
    if ($adUser) {

        $null = Unlock-ADAccount -Identity $adUser
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetIdentifier  = "$($adUser.SID.value)"
            TargetDisplayName = "$($formObject.UserPrincipalName)"
            Message           = "ActiveDirectory action: [UpdateAccount]. Unlock account for: [$($formObject.UserPrincipalName)] executed successfully."
            IsError           = $false
        }

        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ActiveDirectory action [UpdateAccount] Unlock account for: [$($formObject.UserPrincipalName)] executed successfully"
    }
    else {
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetIdentifier  = ""
            TargetDisplayName = "$($formObject.UserPrincipalName)"
            Message           = "ActiveDirectory action: [UpdateAccount]. Unlock account for: [$($formObject.UserPrincipalName)] cannot be executed. The account cannot be found in the AD."
            IsError           = $true
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Error "ActiveDirectory action: [UpdateAccount]. Unlock account for: [$($formObject.UserPrincipalName)] cannot be executed. The account cannot be found in the AD."
    }
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = 'UpdateAccount'
        System            = 'ActiveDirectory'
        TargetIdentifier  = '' # optional (free format text)
        TargetDisplayName = "$($formObject.UserPrincipalName)"
        Message           = "ActiveDirectory action: [UpdateAccount]. Unlock account failed for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "ActiveDirectory action: [UpdateAccount]. Unlock account failed for : [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
}
###################################################################
