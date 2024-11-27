# JSON content embedded in the PowerShell script
#Author: Chris Titus
$jsonContent = @'
{
  "WPFTweaksRestorePoint": {
    "Content": "Create Restore Point",
    "Description": "Creates a restore point at runtime in case a revert is needed from SMT modifications",
    "category": "Essential Tweaks",
    "panel": "1",
    "Checked": "False",
    "Order": "a001_",
    "InvokeScript": [
      "
      # Check if the user has administrative privileges
      if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
          Write-Host 'Please run this script as an administrator.'
          return
      }

      # Check if System Restore is enabled for the main drive
      try {
          # Try getting restore points to check if System Restore is enabled
          Enable-ComputerRestore -Drive $env:SystemDrive
      } catch {
          Write-Host 'An error occurred while enabling System Restore: $_'
          return
      }

      # Check if the SystemRestorePointCreationFrequency value exists
      $exists = Get-ItemProperty -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -ErrorAction SilentlyContinue
      if ($null -eq $exists) {
          Write-Host 'Changing system to allow multiple restore points per day'
          Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -Value 0 -Type DWord -Force -ErrorAction Stop | Out-Null
      }

      # Attempt to load the required module for Get-ComputerRestorePoint
      try {
          Import-Module Microsoft.PowerShell.Management -ErrorAction Stop
      } catch {
          Write-Host 'Failed to load the Microsoft.PowerShell.Management module: $_'
          return
      }

      # Get all the restore points for the current day
      try {
          $existingRestorePoints = Get-ComputerRestorePoint | Where-Object { $_.CreationTime.Date -eq (Get-Date).Date }
      } catch {
          Write-Host 'Failed to retrieve restore points: $_'
          return
      }

      # Check if there is already a restore point created today
      if ($existingRestorePoints.Count -eq 0) {
          $description = 'System Restore Point created by SMT'
          Checkpoint-Computer -Description $description -RestorePointType 'MODIFY_SETTINGS'
          Write-Host -ForegroundColor Green 'System Restore Point Created Successfully'
      } else {
          Write-Host 'A restore point has already been created today.'
      }
      "
    ]
  }
}
'@

# Convert JSON content to a PowerShell object
$jsonObject = $jsonContent | ConvertFrom-Json

# Extract the script from the JSON object
$script = $jsonObject.WPFTweaksRestorePoint.InvokeScript -join "`n"

# Execute the extracted script
Invoke-Expression $script