try {Get-ChildItem e:\dog.txt -ErrorAction Stop} #ErrorAction tells a non-terminating error to be a terminating one
# Run the code, if there is a terminating signal, do something (whats in the catch block) (traps the code)
catch [System.Management.Automation.ItemNotFoundException] {"File Not Found"} # Replaces the red test with code
# What to do with the error
catch {"another error happened"}
finally{} #executes regardless of whether there is an error or not.  Used for cleanup after errors
