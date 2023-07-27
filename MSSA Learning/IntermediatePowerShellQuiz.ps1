# 1 Testing the use of methods
# Q1.1 Create a function that takes a string as a parameter and reverses the case, upper case changed to lower case and lower case changed to upper case



# Accept a string
[String]$String = "This is a Test"
# Isolate each character
# Compare it to an uppercase variant
# If it is the same - change to lower
# If it is different - change it to upper

function ReverseCase {
  Param ([string]$InitialString)
  [string]$RevCaseString = ''
  0..($InitialString.length - 1) | ForEach-Object {
    if ($InitialString[$_].ToString().ToUpper() -ceq $InitialString[$_].ToString()) {$RevCaseString += $InitialString[$_].ToString().ToLower()}
    else {$RevCaseString += $InitialString[$_].ToString().ToUpper()}
  }
  return $RevCaseString
}
ReverseCase -InitialString "tHISiSAsTRING"

function ReverseTheCase {
  Param ([string]$StringIn)
}