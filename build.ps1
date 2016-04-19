$profileLocation = Split-Path -Parent $PROFILE

if (!(Test-Path $profileLocation)) {
   mkdir $profileLocation 
}
cp .\Microsoft.PowerShell_profile.ps1 $profile