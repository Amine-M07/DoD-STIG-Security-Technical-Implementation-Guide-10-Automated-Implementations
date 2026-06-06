<#
.SYNOPSIS
    This PowerShell script ensures Kernel DMA Protection enforcement by configuring the
    DeviceEnumerationPolicy registry value as required by STIG WN11-EP-000310.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-EP-000310
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-EP-000310/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script as Administrator.

    Example syntax:
    PS C:\> .\WN11-EP-000310.ps1
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection"
$valueName    = "DeviceEnumerationPolicy"
$valueData    = 0   # Block All (per STIG requirement)

# Ensure registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set DeviceEnumerationPolicy to 0 (Block All)
New-ItemProperty -Path $registryPath `
                 -Name $valueName `
                 -Value $valueData `
                 -PropertyType DWord `
                 -Force | Out-Null

# Verify compliance
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($currentValue.$valueName -eq 0) {
    Write-Host "Compliant: Kernel DMA Protection is set to Block All (DeviceEnumerationPolicy = 0)."
} else {
    Write-Host "Non-Compliant: Failed to configure Kernel DMA Protection correctly."
}
