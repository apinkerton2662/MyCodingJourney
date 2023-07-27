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

# Q2.3 Determine how many different ways this cmdlet can be run we call it "parameter sets"

# This cmdlet can be run in 6 parameter sets

# Q2.4 Find an example in the help that shows processes with a working set greater than a specified size

# Example 3: Get all processes with a working set greater than a specified size Get-Process | Where-Object {$_.WorkingSet -gt 20000000}


# 3 Discovering what is the output/result of running a cmdlet using Get-Member

# Find what object is created when you run the Get-Service cmdlet

# Q3.1 What is the name of the object that is the result/output of the cmdlet

Get-Service | Get-Member
# System.Service.ServiceController

# Q3.2 What Properties are available in the Object produced by this cmdlet

Get-Service | Get-Member
# BinaryPathName            Property      System.String {get;set;}
# CanPauseAndContinue       Property      bool CanPauseAndContinue {get;}        
# CanShutdown               Property      bool CanShutdown {get;}
# CanStop                   Property      bool CanStop {get;}
# Container                 Property      System.ComponentModel.IContainer Cont… 
# DelayedAutoStart          Property      System.Boolean {get;set;}
# DependentServices         Property      System.ServiceProcess.ServiceControll… 
# Description               Property      System.String {get;set;}
# DisplayName               Property      string DisplayName {get;set;}
# MachineName               Property      string MachineName {get;set;}
# ServiceHandle             Property      System.Runtime.InteropServices.SafeHa… 
# ServiceName               Property      string ServiceName {get;set;}
# ServicesDependedOn        Property      System.ServiceProcess.ServiceControll… 
# ServiceType               Property      System.ServiceProcess.ServiceType Ser… 
# Site                      Property      System.ComponentModel.ISite Site {get… 
# StartType                 Property      System.ServiceProcess.ServiceStartMod… 
# StartupType               Property      Microsoft.PowerShell.Commands.Service… 
# Status                    Property      System.ServiceProcess.ServiceControll… 
# UserName                  Property      System.String {get;set;}

# Q3.3 What Methods are available in the Object produced by this cmdlet

# Close                     Method        void Close()
# Continue                  Method        void Continue()
# Dispose                   Method        void Dispose(), void IDisposable.Disp… 
# Equals                    Method        bool Equals(System.Object obj)
# ExecuteCommand            Method        void ExecuteCommand(int command)       
# GetHashCode               Method        int GetHashCode()
# GetLifetimeService        Method        System.Object GetLifetimeService()     
# GetType                   Method        type GetType()
# InitializeLifetimeService Method        System.Object InitializeLifetimeServi… 
# Pause                     Method        void Pause()
# Refresh                   Method        void Refresh()
# Start                     Method        void Start(), void Start(string[] arg… 
# Stop                      Method        void Stop(), void Stop(bool stopDepen… 
# WaitForStatus             Method        void WaitForStatus(System.ServiceProc…

# Q3.4 Find the object types that are contained within the following properties: Name, DisplayName, CanStop, Status

Get-service | Get-Member

# Name - Alias Property for ServiceName = string
# DisplayName string
# CanStop bool
# Status ServiceControllerStatus Object

# 4 Discovering Modules
# Q4.1 List all of the modules that are available
get-module -ListAvailable

# Q4.2 From the results of the previous command what folders are the modules found in
get-help *psmodule*
$env:PSModulePath

# Q4.3 What command would you use to install the module "SubnetTools" from the PowerShell Gallery

Install-Module -Name SubnetTools
