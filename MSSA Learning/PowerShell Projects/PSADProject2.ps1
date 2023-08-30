function Restore-DeletedADObject {
  <#
  .SYNOPSIS
    This command will restore AD users from the AD Recycle bin
  .DESCRIPTION
    This command will check for all deleted users and list them in a GUI, allowing the users that 
    need to be restored to be slected and then automatically restored to AD
  .EXAMPLE
    Restore-DeletedADObject
    This will present a list of deleted users for selection to resore them to AD
  .NOTES
    General notes
      Created By: Brent Denny
      Created On: 01-Feb-2022
  #>
  # Find all of the deleted objects in AD  
  $DeletedObjects = Get-ADObject -LDAPFilter:"(msDS-LastKnownRDN=*)" -IncludeDeletedObjects | Where-Object { $_.Deleted -eq $true }
  $ADObjectsChosen = $DeletedObjects | Out-GridView -OutputMode Multiple  # Choose which objects to restore
  $ADObjectsChosen | Restore-ADObject -Confirm:$false # This restores the chosen object
  # this finds the restored objects in AD  
  $RestoredObjects = Get-ADObject -Filter * | Where-Object { $_.ObjectGuid -in $ADObjectsChosen.ObjectGuid }  
  return $RestoredObjects   # Show the restored objects on the screen (this is the optional requirement)
}
    