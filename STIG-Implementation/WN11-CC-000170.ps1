<#
.SYNOPSIS
    This PowerShell script enables the policy "Allow Microsoft accounts to be optional"
    by ensuring the MSAOptional registry value is set to 1.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000170
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-CC-000170/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run this script as Administrator.

    Example syntax:
    PS C:\> .\WN11-CC-000170.ps1
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName    = "MSAOptional"
$valueData    = 1

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set MSAOptional to 1 (Enabled)
New-ItemProperty -Path $registryPath `
                 -Name $valueName `
                 -Value $valueData `
                 -PropertyType DWord `
                 -Force | Out-Null

# Verify compliance
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($currentValue.$valueName -eq 1) {
    Write-Host "Compliant: '$valueName' is set to 1 (Microsoft accounts optional)."
} else {
    Write-Host "Non-Compliant: Failed to set '$valueName' correctly."
}
