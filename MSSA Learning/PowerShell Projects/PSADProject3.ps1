<#
# This is the Powershell Challenge Project # 3
Run these commands on LON-CL1 before starting
# Create OU
# New-ADOrganizationalUnit -Name AdatumGroups -Path 'DC=adatum,DC=com' -ErrorAction SilentlyContinue

# Global groups
New-ADGroup -Name SalesAdmin -GroupScope Global  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name MktgAdmin -GroupScope Global  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name DevAdmin -GroupScope Global  -Path 'ou=AdatumGroups,dc=adatum,dc=com'

# Universal groups
New-ADGroup -Name AllAdmin -GroupScope Universal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'

# Domain Local groups
New-ADGroup -Name ColorPtr -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name SalesDB -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name MktgData -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name CommonData -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name BWPtr -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name CustomerDB -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
New-ADGroup -Name AllowRemote -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'

# Nesting groups
Add-ADGroupMember -Identity ColorPtr -Members (Get-ADGroup -Filter {Name -eq 'MktgAdmin'})
Add-ADGroupMember -Identity SalesDB -Members (Get-ADGroup -Filter * | Where-Object {$_.Name -in ('SalesAdmin','MktgAdmin')})
Add-ADGroupMember -Identity MktgData -Members (Get-ADGroup -Filter {Name -eq 'MktgAdmin'})
Add-ADGroupMember -Identity CommonData -Members (Get-ADGroup -Filter {Name -eq 'AllAdmin'})
Add-ADGroupMember -Identity BWPtr -Members (Get-ADGroup -Filter {Name -eq 'AllAdmin'})
Add-ADGroupMember -Identity CustomerDB -Members (Get-ADGroup -Filter * | Where-Object {$_.Name -in ('SalesAdmin','DevAdmin')})
Add-ADGroupMember -Identity AllowRemote -Members (Get-ADGroup -Filter {Name -eq 'SalesAdmin'})
Add-ADGroupMember -Identity AllAdmin -Members (Get-ADGroup -Filter * | Where-Object {$_.Name -in ('SalesAdmin','DevAdmin','MktgAdmin')})

# Adding Admin users from each department to relevant Global groups
Add-ADGroupMember -Identity SalesAdmin -Members (Get-ADUser -Filter * | Where-Object {$_.SamAccountname -in ('Maureen','Allan','Jessie')})
Add-ADGroupMember -Identity MktgAdmin -Members (Get-ADUser -Filter * | Where-Object {$_.SamAccountname -in ('Ada','Ernie','Julian')})
Add-ADGroupMember -Identity DevAdmin -Members (Get-ADUser -Filter * | Where-Object {$_.SamAccountname -in ('Jasper','Margret','Jodie')})
#>

<# Create a function that achieves the following:
Given a user's SamAccountName, list all their related groups (immediate and nested groups)
#>

function Get-RecursiveGroupList {
  <#
  .SYNOPSIS
    Retrieves the immediate and nested groups of a user.
  .DESCRIPTION
    Accepts an SamAccountName and recursively searches for groups within groups.  Displays the results.
  .NOTES
    Function created for PowerShell Project 3
  .PARAMETER User
    This is the SamAccountname of the user you wish to look up.  
  #>
  
  
  param ($User)
  function Get-ADSubGroups {
    param ($Identity)
    $Groups = Get-ADPrincipalGroupMembership -Identity $Identity
    foreach ($G in $Groups) {
      Get-ADSubGroups -Identity $Identity
    }
  }
  $UserSAN = Get-ADUser -Identity $User
  Get-ADSubGroups -Identity $UserSAN
}

Get-RecursiveGroupList -User Jasper 

$Groups