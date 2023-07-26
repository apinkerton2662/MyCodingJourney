Measure-Command -Expression {
  Get-ADUser -Filter {samAccountName -eq 'Lara'}
} | Select-Object Milliseconds

