<#
.SYNOPSIS
    This PowerShell script checks and remediates STIG WN11-CC-000110 by ensuring HTTP printing is disabled on Windows 11 systems.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-CC-000110/

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Example syntax:
    PS C:\> .\WN11-CC-000110-CheckAndRemediate.ps1
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$valueName = "DisableHTTPPrinting"
$expectedValue = 1

# Ensure the registry key exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Registry path created: $registryPath"
}

# Try to get current value and check compliance
try {
    $currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction Stop).$valueName

    if ($currentValue -eq $expectedValue) {
        Write-Host "WN11-CC-000110: Compliant"
    }
    else {
        Write-Host "WN11-CC-000110: Non-Compliant – Current value is $currentValue"
        Write-Host "Remediating by setting '$valueName' to '$expectedValue'..."

        Set-ItemProperty -Path $registryPath -Name $valueName -Value $expectedValue

        Write-Host "Remediation complete."
    }
}
catch {
    Write-Host "WN11-CC-000110: Non-Compliant – Registry value not found. Creating and setting value..."

    New-ItemProperty -Path $registryPath `
        -Name $valueName `
        -Value $expectedValue `
        -PropertyType DWord `
        -Force | Out-Null

    Write-Host "Remediation complete."
}
