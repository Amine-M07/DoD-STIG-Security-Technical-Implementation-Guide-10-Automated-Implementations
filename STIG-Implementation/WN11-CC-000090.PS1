<#
.SYNOPSIS
    This PowerShell script checks and remediates STIG WN11-CC-000090 by ensuring
    registry-based Group Policy settings are processed during policy refreshes,
    even when Group Policy Objects have not changed.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-CC-000090/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :

.USAGE
    Example syntax:
    PS C:\> .\WN11-CC-000090-Remediation.ps1
#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"
$valueName = "NoGPOListChanges"
$valueData = 0  # 0 = Process registry policies even if GPOs haven't changed

# Create the key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Registry path created: $registryPath"
}

# Set the required value to remediate the STIG
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

Write-Host "WN11-CC-000090 remediated successfully. '$valueName' set to '$valueData'."
