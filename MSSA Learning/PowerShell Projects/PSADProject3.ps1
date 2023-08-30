<# 
This is the third of four PowerShell Active Directory Challenges.
In this challenge, you must create a function that accomplishes the following:

Given a user's SamAccountName, list all their related groups (immediate and nested groups)
Nested Groups are groups placed inside other groups
Find all of the groups that the user is a member of
For each of these groups, find all the groups they are members of , and repeat this until you have found all of the nested groups.
Display the Name and Scope of each group on screen...
#>

function Find-AssociatedGroupMembership {
  <#
  .SYNOPSIS
    This command will find all related groups given a users samaccountname
  .DESCRIPTION
    This command will find all of the groups a user is a member of and then
    will locate all groups that those groups are a member of recursively and display them on screen
  .EXAMPLE
    Find-AssociatedGroupMembership
    This command will find all related groups given a users samaccountname
  .PARAMETER SamAccountName
    This is the SamAccountName that is associated with the use in question  

  #>
  Param ($SamAccountName)
  function Get-MemberOf {
    Param($ADObject)
    $Groups = Get-ADPrincipalGroupMembership -Identity $ADObject
    foreach ($Group in $Groups) {
      $Group | Select-Object -Property Name, GroupScope
      Get-MemberOf -ADObject $Group
    }
  }
  $ADAccount = Get-ADUser -Identity $SamAccountName
  Get-MemberOf -ADObject $ADAccount
} 
Find-AssociatedGroupMembership -SamAccountName Jasper

