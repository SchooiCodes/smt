# get latest download url
$URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$URL = (Invoke-WebRequest -Uri $URL).Content | ConvertFrom-Json |
        Select-Object -ExpandProperty "assets" |
        Where-Object "browser_download_url" -Match '.msixbundle' |
        Select-Object -ExpandProperty "browser_download_url"
Invoke-WebRequest -Uri $URL -OutFile "Setup.msix" -UseBasicParsing
Add-AppxPackage -Path "Setup.msix"
Remove-Item "Setup.msix"