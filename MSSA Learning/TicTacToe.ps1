<# This script represents working out how to use logic to code a Tic-Tac-Toe game in Powershell.  We worked together in class to devise and write the code in real time. #>

# Interactive game
#  1 | 2 | 3
# ---+---+---
#  4 | 5 | 6
# ---+---+---
#  7 | 8 | 9
[CmdletBinding()]
Param ()
function DisplayBoard {
  param ($Board)
  # print board on screen
    ### $($Array[x] is special sytax that evaluates the array element first when inside double quotes/string)
    Write-Host
    Write-Host " $($Board[0]) | $($Board[1]) | $($Board[2])"
    Write-Host "---+---+---"
    Write-Host " $($Board[3]) | $($Board[4]) | $($Board[5])"
    Write-Host "---+---+---"
    Write-Host " $($Board[6]) | $($Board[7]) | $($Board[8])"
    Write-Host "---+---+---"
    Write-Host
}

do{
  $CurrentPlayer = 'X','O' | Get-Random
  $GameOver = $false
  $Draw = $false
  [System.Collections.ArrayList]$T3Board = @(1..9)
  do {
    DisplayBoard -Board $T3Board
    do {
      $Choice = Read-Host -Prompt "Player $CurrentPlayer, please select a grid"
      # check for wrong responses (not 1-9, or already chosen)
      # if wrong, ask again
      $GoodSpots = @(1..9)
      if ($T3Board -contains $Choice -and $GoodSpots -contains $Choice) {$TryAgain = $false}
      else {$TryAgain = $true}
    } while ($TryAgain -eq $true)
    Write-Verbose "the board before the change $T3Board"
    $T3Board[$Choice - 1] = $CurrentPlayer
    Write-Verbose "the board after the change $T3Board"
    Write-Debug "this is the board just after the change"

    $WinningLines = @(
      @(0,1,2),
      @(3,4,5),
      @(6,7,8),
      @(0,4,8),
      @(2,4,6),
      @(0,3,6),
      @(1,4,7),
      @(2,5,8)
    )
    foreach ($W in $WinningLines) {
      $PositionValues = ($T3Board[$W] | Select-Object -Unique)
      Write-Verbose "the value from the winning line $T3Board"
      if ($PositionValues.count -eq 1) {
        $GameOver = $true
        break
      } 
    }
    if ($GameOver -eq $false -and ($T3Board | Select-Object -Unique).count -eq 2) {
      $Draw = $true
      $GameOver = $true
      break
    }
    if ($GameOver -eq $false) {
      if ($CurrentPlayer -eq 'X') {$CurrentPlayer = 'O'}
      else {$CurrentPlayer = 'X'}
  }
    # check game state win lose draw
    # Win = 3 in a row, col, diag
  } until ($GameOver -eq $true -or $Draw -eq $true)
  DisplayBoard -Board $T3Board
  if ($GameOver -eq $true -and $Draw -eq $false) {
    Write-Host "$CurrentPlayer, you are the winner"
  } elseif ($Draw -eq $true) {
    Write-Host "It is a draw"
  }
  $Again = Read-Host -Prompt 'Do you want to play again (Yes/No)'
  if ($Again -like 'y*') {$KeepPlaying = $true}
  else {$KeepPlaying = $false}
  # check for play again and then reset board
} while ($KeepPlaying -eq $true)