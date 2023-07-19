#Object Members and variables
#Variables are very flexible
$Service = Get-Service -Name bits
$Service | GM
$Service.Status
$Service.Stop()
$Msg = "Service Name is $($service.name.ToUpper())"
$msg
#Working with multiple objects
$Services = Get-Service
$Services[0]
$Services[0].Status
$Services[-1].Name
"Service Name is $($Services[4].DisplayName)"
"Service Name is $($Services[4].name.ToUpper())"