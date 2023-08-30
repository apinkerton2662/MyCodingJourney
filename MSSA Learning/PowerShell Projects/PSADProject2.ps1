<# 
This is the second of four PowerShell Active Directory Challenges.
In this challenge, you must create a function that accomplishes the following:

Recover deleted user from Domain Controller Recycle-Bin
Write a function that does the following:
Lists all deleted object using Out-Gridview
Allows someone to choose which deleted user/s are to be restored
Restore the chosen user/s
Show the restored AD object on screen to prove restoration was successful
Add this function to the previous module from Project 1
#>
function Restore-DeletedADObject {
  <#
  .SYNOPSIS
    Restores selected users from AD Recycle-Bin
  .DESCRIPTION
    This command will scan the AD Recycle Bin, show the user a list of deleted users, and restore the selected users.
  #>
  # Find all of the deleted objects in AD  
  $DeletedObjects = Get-ADObject -LDAPFilter:"(msDS-LastKnownRDN=*)" -IncludeDeletedObjects | Where-Object { $_.Deleted -eq $true }
  $ADObjectsChosen = $DeletedObjects | Out-GridView -OutputMode Multiple  # Choose which objects to restore
  $ADObjectsChosen | Restore-ADObject -Confirm:$false # This restores the chosen object
  # this finds the restored objects in AD  
  $RestoredObjects = Get-ADObject -Filter * | Where-Object { $_.ObjectGuid -in $ADObjectsChosen.ObjectGuid }  
  return $RestoredObjects   # Show the restored objects on the screen (this is the optional requirement)
}
    