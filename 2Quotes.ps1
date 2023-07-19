#Quotation Markes

#Double quotes resolve the variable
$i = "Powershell"

"This is the variable $i, and $i Rocks!"
'This is the variable $i, and $i Rocks!'
"This is the variable `$i, and $i Rocks!"

$computername = "Client"
Get-Service -name bits -ComputerName "$ComputerName" | 
    Select MachineName, Name, Status