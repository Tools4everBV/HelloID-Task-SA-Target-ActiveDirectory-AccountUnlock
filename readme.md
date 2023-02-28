
# HelloID-Task-SA-Target-ActiveDirectory-AccountUnlock

## Prerequisites

- [ ] The HelloID SA on-premises agent installed

- [ ] The ActiveDirectory module is installed on the server where the HelloID SA on-premises agent is running.

## Description

This code snippet will unlock a user account within Active Directory and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties of the `Get-ADUser` cmdlet, while the values represent the values entered in the form.

> To view an example of form output, please refer to the JSON code pasted below.

```json
{
   "UserPrincipalName": "testuser@mydomain.local"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hashtable is appropriately adjusted to match your form fields.

2. Imports the ActiveDirectory module.

3. Verifies that the account that must be unlocked exists based on the `userPrincipalName` using the `Get-ADUser` cmdlet.

4. If the user does exist, the account is unlocked using the `Unlock-ADAccount` cmdlet, otherwise an error is generated.
