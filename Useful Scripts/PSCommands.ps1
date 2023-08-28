<# These are commands that I found useful while studying with MSSA.  This hopefully develops into a gallery for use in the future. #>

<# AZURE POWERSHELL COMMANDS #>

# Check Powershell Version
$PSVersionTable.PSVersion

# Set execution policy for installation of Powershell Module
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install the AZ Powershell Module
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

# Connect to your Azure Account
Connect-AzAccount

# Review your subscriptions
Get-AzSubscription

# View your resource groups
Get-AzResourceGroup

# Create a new Resource Group
New-AzResourceGroup -Name ResourceGroup1 -Location EastUs

# Prompt for credentials and store as variable
$cred = Get-Credential -Message "Enter an admin username and password for the operating system"

# Define VM Parameters and store in variable
$vmParams = @{
  ResourceGroupName   = 'ResourceGroup1'
  Name                = 'TestVM1'
  Size                = 'Standard_D2s_v3'
  Location            = 'EastUs'
  ImageName           = 'Win2019Datacenter'
  PublicIpAddressName = 'TestPublicIp'
  Credential          = $cred
  OpenPorts           = 3389
}

# Create a new VM with the $vmParams and store in variable
$newVM1 = New-AzVM @vmParams

# Identify configuration settings for new VM
$newVM1.OSProfile | Select-Object ComputerName, AdminUserName
$newVM1 | Get-AzNetworkInterface | Select-Object -ExpandProperty IpConfigurations | Select-Object Name, PrivateIpAddress

# Get Resource group from VM and store as variable
$rgName = $NewVM1.ResourceGroupName

# Get public IP for VM and store in variable.
$publicIp = Get-AzPublicIpAddress -Name TestPublicIp -ResourceGroupName $rgName

$publicIp | Select-Object Name, IpAddress, @{n = 'FQDN'; e = { $_.DnsSettings.Fqdn } }

# Create a data disk and add to VM
Add-AzVMDataDisk -VM $newVM1 -Name "disk1" -LUN 0 -Caching ReadOnly -DiskSizeinGB 1 -CreateOption Empty
Update-AzVM -ResourceGroupName ResourceGroup1 -VM $newVM1