# Diffie-Hellman calculator

#Computer A
$aSecret = 4

$g = 15
$p = 43257623576423
# Share $g $p with Computer B

$A = [math]::Pow($g,$aSecret) % $p

# Share $A with Computer B
# Receive $B from Computer B
$B

#Calculate Diffie Helmen key using $B
$DHKeyA = [math]::Pow($B,$aSecret) % $p
$DHKeyA
#--------------------------------------------
#Computer B
$bSecret = 3

# Receives $g and $p from other computer
$g = 15
$p = 4325762357

$B = [math]::Pow($g,$bSecret) % $p

# Share $B with Computer A
# Receive $A from Computer A
$A

# Calculate Diffie Helman key using $A
$DHKeyB = [math]::Pow($A,$bSecret) % $p
$DHKeyB
