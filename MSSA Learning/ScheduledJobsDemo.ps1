$SchedJobOpts = New-ScheduledJobOption -RunElevated -HideInTaskScheduler
$SchedJobTrg = New-JobTrigger -Once -At (Get-Date).AddMinutes(1)
Register-ScheduledJob -Name BlueSJ -ScriptBlock {'hello'} -Trigger $SchedJobTrg -ScheduledJobOption $SchedJobOpts
Get-Job -IncludeChildJob
