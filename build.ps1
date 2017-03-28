$profileLocation = Split-Path -Parent $PROFILE

if (!(Test-Path $profileLocation)) {
   mkdir $profileLocation 
}
Copy-Item .\Microsoft.PowerShell_profile.ps1 $profile