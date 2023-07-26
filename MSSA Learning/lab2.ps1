<# Powershell-Lab-02 #>
#Exercise 1: Creating and managing Active Directory objects
#Exercise scenario 1
#In this exercise, you'll create and manage Active Directory objects 
#to create an organizational unit (OU) for a branch office, 
#along with groups for OU administrators. 
#You'll create accounts for a user and computer in the branch office, 
#in the default OU, and add the user to the administrators group. 
#You'll later move the user and computer to the OU that you created 
#for the branch office. You'll use individual Windows PowerShell 
#commands to accomplish these tasks from a client computer.

#The main tasks for this exercise are:

#Create a new OU for a branch office.
#Create a group for branch office administrators.
#Create a user and computer account for the branch office.
#Move the group, user, and computer accounts to the branch office OU.

#Task 1: Create a new OU for a branch office
#From LON-CL1, use Windows PowerShell to create a new OU named London.
Get-Command *ad*organ*

New-ADOrganizationalUnit -Name London -Path 'dc=adatum,dc=com'

#Task 2: Create a group for branch office administrators
#In the PowerShell console, create the London Admins global security group.
New-ADGroup -Name 'London Admins' -GroupScope Global

#Task 3: Create a user and computer account for the branch office
#In the PowerShell console, create a user account for the user Ty Carlson.
New-AdUser -Name 'Ty Carlson'

#Add the user to the London Admins group.
Get-ADGroup -Filter *
Add-ADGroupMember -Identity 'London Admins' -Members 'Ty Carlson'
Get-ADgroupmember -identity 'london admins'

#Create a computer account for the LON-CL2 computer.
New-ADComputer -Name 'LON-CL2'

Get-ADOrganizationalUnit -Filter *
Get-ADUser -Filter *



Move-ADObject -Identity 'CN=Ty Carlson,CN=Users,DC=Adatum,DC=com' -TargetPath 'OU=London,DC=Adatum,DC=com'