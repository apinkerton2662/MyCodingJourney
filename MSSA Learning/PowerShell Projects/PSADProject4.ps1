<# PowerShell Active Directory Project 4 #>
# Run the following before starting

$SalesUsers = Get-ADUser -filter {Department -eq 'Sales'} -Properties Department
$ADDisabledOU = if (-not (Test-Path 'AD:\OU=DisabledUsers,DC=Adatum,DC=com')) {New-ADOrganizationalUnit   -Path 'DC=adatum,DC=com' -Name DisabledUsers} 
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
    Set-ADAccountPassword -identity $User -Reset -NewPassword $NewPass
    Disable-ADAccount -identity $User
    Move-ADObject -identity $User -TargetPath "OU=DisabledUsers,DC=Adatum,DC=Com"
  }
}

Disable-aduserscsv -filename $Filename


Get-ADUser -SearchBase "OU=DisabledUsers,DC=Adatum,DC=com"


$NewPass = New-Password | ConvertTo-SecureString