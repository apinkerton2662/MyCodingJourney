# These are my attempts at the labs from "Learn Powershell in a month of lunches"
# Chapter 3
# 1
Update-Help
# Update-Help

# 2
Get-Command *HTML*
Get-Help ConvertTo-Html -ShowWindow
# ConvertTo-Html

# 3
Get-Command *to*file*
Get-Command *out*
Get-Help Out-File -ShowWindow
# Out-File

# 4
Get-Command -Noun Process
# 5 commands

# 5 
Get-Command -Noun *break*
Get-Help Set-PSBreakpoint -ShowWindow
# Set-PSBreakpoint

# 6
Get-Command -Noun Alias

# 7
Get-Command -Noun Transcript
Get-Help start-transcript -ShowWindow
# Start-Transcript

# 8
Get-Help get-process -ShowWindow
Get-Process -Name Process

# 9
Get-Process -Name pwsh -IncludeUserName

# 10
Get-Command -Verb Invoke
Get-Help Invoke-Command -ShowWindow 
Invoke-Command
