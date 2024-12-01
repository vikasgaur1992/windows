# Define the software name to look for
$softwareNamePattern = "Microsoft Visual C++*"
 
# Search both 32-bit and 64-bit registry paths
$uninstallPaths = @(
    Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
                  "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" |
    Where-Object { $_.GetValue("DisplayName") -like $softwareNamePattern } |
    ForEach-Object { $_.GetValue("UninstallString") }
)
 
# Execute each uninstall command found
if ($uninstallPaths) {
    foreach ($path in $uninstallPaths) {
        Write-Output "Uninstalling: $path"
& cmd /c "$path /quiet /norestart"
    }
} else {
    Write-Output "No matching software found for '$softwareNamePattern'."
}
