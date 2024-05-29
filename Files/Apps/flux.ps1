# Download f.lux installer
$fluxInstallerUrl = "https://justgetflux.com/flux-setup.exe"
$installerPath = "flux-setup.exe"

Invoke-WebRequest -Uri $fluxInstallerUrl -OutFile $installerPath

# Run the installer silently
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

# Optionally, delete the installer after installation
Remove-Item $installerPath
