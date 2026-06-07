<#
.SYNOPSIS
    This PowerShell script configures User Account Control (UAC) to automatically deny
    elevation requests for standard users by setting the ConsentPromptBehaviorUser registry value.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000255
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-SO-000255/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run this script as Administrator.

    Example syntax:
    PS C:\> .\WN11-SO-000255.ps1
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName    = "ConsentPromptBehaviorUser"
$valueData    = 0  # Automatically deny elevation requests for standard users

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set ConsentPromptBehaviorUser to 0
New-ItemProperty -Path $registryPath `
                 -Name $valueName `
                 -Value $valueData `
                 -PropertyType DWord `
                 -Force | Out-Null

# Verify compliance
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($currentValue.$valueName -eq 0) {
    Write-Host "Compliant: '$valueName' is set to 0 (UAC automatically denies elevation requests for standard users)."
} else {
    Write-Host "Non-Compliant: Failed to set '$valueName' correctly."
}
