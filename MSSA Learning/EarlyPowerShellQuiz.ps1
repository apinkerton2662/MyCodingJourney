# Entry Level PowerShell Quiz
# 1. Using Pipelines

# Q1 Write a pipeline that displays all running services and show the following properties sorted by the StartType and then by Name
# Properties to show Status, StartType, Name, DisplayName

Get-Service | Select-Object Status, StartType, Name, Displayname
Get-Service | Where-Object Status -eq 'Running' | Sort-Object -Property StartType, Name
# Answer
Get-Service | Where-Object { $_.Status -eq 'Running' } | Sort-Object -Property StartType, Name | Select-Object -Property Status, StartType, Name, DisplayName

# Q1.2 Write a pipeline that will show the some properties of the BIOS information using a CimInstance command
# Show the following properties: BIOSVersion,ReleaseDate
get-command *cim*
get-help Get-CimInstance -showwindow
Get-CimInstance CIM_BIOSElement | Format-List
Get-CimInstance CIM_BIOSElement | Get-Member
# Guess
Get-CimInstance CIM_BIOSElement | Select-Object -Property SMBIOSBIOSVersion, ReleaseDate
# Answer
Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property BIOSVersion, ReleaseDate

# Q1.3 Write a pipeline that shows the four most recent System event log entries and only shows the following
# The EventID and how long ago the entries were geneated in minutes
Get-Command *log
Show-Eventlog -ComputerName 'LON-CL1'
Get-Help Get-WinEvent -ShowWindow
Get-WinEvent -LogName System -MaxEvents 4
Get-WinEvent -LogName System -MaxEvents 4 | Select-Object -Property *
# Answer
Get-WinEvent -LogName System -MaxEvents 4 | Select-Object -Property ID, @{Name = "MinutesAgo"; Expression = { ((Get-Date) - $_.TimeCreated).minutes } }

# 2 Using Help
# Open the full help page for the cmdlet Get-Process to answer the following questions
# Q2.1 Determine what type of object can the ComputerName parameter accept

Get-Help Get-Process -showwindow

# ComputerName accepts system.string[] 

# Q2.2 Determine which parameters can accept pipeline input and take note of the pipeline method

# -ComputerName (ByProperty)
# -Id (ByProperty)
# -InputObject (ByValue)
# -Name (ByProperty)
# This i
