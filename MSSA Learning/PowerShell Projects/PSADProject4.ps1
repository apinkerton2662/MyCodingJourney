<# 
This is the fourth of four PowerShell Active Directory Challenges.
In this challenge, you must create a function that accomplishes the following:

Use the E:\DisableList.csv to find and disable the users in the list
When disabling the users do all of the following:
Modify the Users "Info" attribute to include the original DN of the user
"CN=Brian Ferry,OU=Sales,DC=Adatum,DC=com was the original DN"
Disable the Account
Change the password to a random password with 1 number, 7 lowercase, 3 uppercase characters
Move the diabled account to the OU called "DisabledUsers"
#>

$SalesUsers = Get-ADUser -Filter { Department -eq 'Sales' } -Properties Department
$ADDisabledOU = if (-not (Test-Path 'AD:\OU=DisabledUsers,DC=Adatum,DC=com')) { New-ADOrganizationalUnit   -Path 'DC=adatum,DC=com' -Name DisabledUsers } 
$UsersToDisable = $SalesUsers | Get-Random -Count 5
$UsersToDisable | 
  Select-Object -Property Name, Department | 
  ConvertTo-Csv -NoTypeInformation |
  Out-File e:\DisableList.csv -Force


function New-Password {
  param (
    [int]$NumberCount = 1,
    [int]$LowerCaseCount = 7,
    [int]$UpperCaseCount = 3
  )
  $NewPW = ''

  # Generate Random Numbers
  for ($i = 0; $i -lt $NumberCount; $i++) {
    $NewPW += Get-Random -Minimum 0 -Maximum 10
  }
  # Generate random lowercase letters between ASCII values 97 and 123
  for ($i = 0; $i -lt $LowerCaseCount; $i++) {
    $RLC = [char](Get-Random -Minimum 97 -Maximum 123)
    $NewPW += $RLC
  }
  # Generate random uppercase letters between ASCII values 65 and 91
  for ($i = 0; $i -lt $UpperCaseCount; $i++) {
    $RUC = [char](Get-Random -Minimum 65 -Maximum 91)
    $NewPw += $RUC
  }
  $FinalPW = -join ($NewPw.ToCharArray() | Get-Random -Count $NewPw.Length)
  return $FinalPW
}

$FileName = "E:\DisableList.csv"
function Disable-ADUsersCSV {
  param (
    [string]$FileName
  )
  $DUsers = Import-Csv -Path $FileName
  foreach ($DUser in $DUsers) {
    $Name = $DUser.Name
    $Dep = $DUser.Department
    $NewPass = ConvertTo-SecureString (New-Password) -AsPlainText -Force
    $User = Get-ADUser -Filter { Name -eq $Name -and Department -eq $Dep }
    Set-ADUser -Identity $User -Replace @{info = $User.DistinguishedName + " was the original DN" }
    Set-ADAccountPassword -Identity $User -Reset -NewPassword $NewPass
    Disable-ADAccount -Identity $User
    Move-ADObject -Identity $User -TargetPath "OU=DisabledUsers,DC=Adatum,DC=Com"
  }
}

Disable-aduserscsv -filename $Filename


Get-ADUser -SearchBase "OU=DisabledUsers,DC=Adatum,DC=com"

