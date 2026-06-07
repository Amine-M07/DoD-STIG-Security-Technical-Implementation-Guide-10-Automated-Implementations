<#
.SYNOPSIS
    This PowerShell script enables PowerShell Script Block Logging by setting the
    EnableScriptBlockLogging registry value to 1 as required by STIG WN11-CC-000326.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000326
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-CC-000326/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run this script as Administrator.

    Example syntax:
    PS C:\> .\WN11-CC-000326.ps1
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$valueName    = "EnableScriptBlockLogging"
$valueData    = 1  # Enable Script Block Logging

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set EnableScriptBlockLogging to 1
New-ItemProperty -Path $registryPath `
                 -Name $valueName `
                 -Value $valueData `
                 -PropertyType DWord `
                 -Force | Out-Null

# Verify compliance
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($currentValue.$valueName -eq 1) {
    Write-Host "Compliant: '$valueName' is set to 1 (PowerShell Script Block Logging Enabled)."
} else {
    Write-Host "Non-Compliant: Failed to set '$valueName' correctly."
}
