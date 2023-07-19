If ($this -eq $that) {
    # commands
} elseif ($those -ne $them) {
    # commands
} elseif ($we -gt $they) {
    # commands
} else {
    # commands
}

$Status = (Get-Service -Name BITS).status
If ($Status -eq "Running") {
    Clear-Host
    Write-Output "Service is being stopped"
    Stop-Service -Name BITS
} Else {
    Clear-Host
    Write-Output "Service is already stopped"
}