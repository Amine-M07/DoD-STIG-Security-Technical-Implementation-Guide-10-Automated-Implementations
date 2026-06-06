<#
.SYNOPSIS
    This PowerShell script ensures that "Audit Handle Manipulation" is enabled for Failure events
    in Advanced Audit Policy Configuration as required by STIG WN11-AU-000583.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000583
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-AU-000583/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script as Administrator.

    Example syntax:
    PS C:\> .\WN11-AU-000583.ps1
#>

# Enable Audit Handle Manipulation - Failure
# Uses auditpol to configure Advanced Audit Policy (preferred method for STIG compliance)

$subcategory = "Handle Manipulation"
$setting     = "failure"

# Configure auditing
auditpol /set /subcategory:"$subcategory" /success:disable /failure:enable | Out-Null

# Verify configuration
$auditStatus = auditpol /get /subcategory:"$subcategory"

if ($auditStatus -match "Failure") {
    Write-Host "Compliant: 'Audit Handle Manipulation' is enabled for Failure events."
} else {
    Write-Host "Non-Compliant: Failed to enable 'Audit Handle Manipulation' for Failure events."
}
