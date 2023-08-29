
function Import-ADUserCSV {
  <#
.SYNOPSIS
  Adds Active Directory users based on CSV input
.DESCRIPTION
  This function imports user information from a CSV file and performs the following tasks:
  1. Creates new OUs if they don't already exist.
  2. Creates new security groups if they don't already exist.
  3. Creates new user accounts in the appropriate groups and OUs.
.NOTES
  This was created for Powershell Project 1
.LINK
  Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
  Import-ADUserCSV -FilePath "E:\NewHires.csv"
  Imports user information from NewHires.csv and creates ADUsers, OUs, and security groups as needed.
#>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, HelpMessage = "Path to the CSV file containing user information.")]
    [string]$FilePath
  )
  
  begin {
    # Import the CSV File and store in variable
    $NewHires = Import-Csv -Path $FilePath
      
    # Get a list of OUs in AD
    $OrgNames = (Get-ADOrganizationalUnit -Filter *).Name
      
    # Get a list of Security Groups
    $SecGroups = (Get-ADGroup -Filter 'GroupCategory -eq "Security"').Name
  }
  
  process {
    # For each department in $NewHires, create OU and security group if not exists
    foreach ($Department in ($NewHires | Select-Object -Property Department -Unique).Department) {
      if ($OrgNames -notcontains $Department) {
        New-ADOrganizationalUnit -Name $Department
      }
      if ($SecGroups -notcontains $Department) {
        New-ADGroup -Name $Department -GroupScope DomainLocal -GroupCategory Security
      }
    }
      
    # For each person in the file, create a new user account
    foreach ($newHire in $NewHires) {
      $UserInfo = @{
        SamAccountName    = ($newHire.FirstName.Substring(0, 1) + $newHire.LastName).ToLower()
        Name              = $newHire.FirstName + " " + $newHire.LastName
        Path              = "OU=" + $newHire.Department + ",DC=Adatum,DC=com"
        UserPrincipalName = $newHire.Upn
        Department        = $newHire.Department
        GivenName         = $newHire.FirstName
        Surname           = $newHire.LastName 
        StreetAddress     = $newHire.StreetAddress
        City              = $newHire.City
        MobilePhone       = $newHire.MobilePhone
        AccountPassword   = (ConvertTo-SecureString $newHire.Password -AsPlainText -Force)
        Office            = $newHire.OfficeName
        Enabled           = $true
      }
          
      $newUser = New-ADUser @UserInfo -PassThru
      Add-ADPrincipalGroupMembership -Identity $newUser -MemberOf $newHire.Department
    }
  }
  
  end {
    # Clean up resources if needed
  }
}

