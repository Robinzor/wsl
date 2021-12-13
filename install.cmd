# Run with Administrator priviledges.
@echo off
@powershell -NoProfile -ExecutionPolicy bypass -noexit "&([ScriptBlock]::Create((cat -encoding utf8 \"%~f0\" | ? {$_.ReadCount -gt 3}) -join \"`n\"))" %*

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName VirtualMachinePlatform
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName Microsoft-Windows-Subsystem-Linux
Write-Host(" ...Downloading WSL2 Kernel Update.")
$kernelURI = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
$kernelUpdate = ((Get-Location).Path) + '\wsl_update_x64.msi'
(New-Object System.Net.WebClient).DownloadFile($kernelURI, $kernelUpdate)
Write-Host(" ...Installing WSL2 Kernel Update.")
msiexec /i $kernelUpdate /qn
Start-Sleep -Seconds 5
Write-Host(" ...Cleaning up Kernel Update installer.")
Remove-Item -Path $kernelUpdate
wsl --set-default-version 2
# manual reboot
# download a distro in the windows store.
