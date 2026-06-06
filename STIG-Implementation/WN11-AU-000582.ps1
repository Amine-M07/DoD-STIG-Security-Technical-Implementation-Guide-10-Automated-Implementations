<#
.SYNOPSIS
    This PowerShell script ensures that "Audit File System" is enabled for Success events
    in Advanced Audit Policy Configuration as required by STIG WN11-AU-000582.

.NOTES
    Author          : Amine Mouammine
    LinkedIn        : https://www.linkedin.com/in/aminemouammine/
    GitHub          : https://github.com/Amine-M07
    Date Created    : 2026-06-06
    Last Modified   : 2026-06-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000582
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-AU-000582/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script as Administrator.

    Example syntax:
    PS C:\> .\WN11-AU-000582.ps1
#>

# Enable Audit File System - Success
# Uses auditpol to configure Advanced Audit Policy (preferred method for STIG compliance)

$subcategory = "File System"
$setting     = "success"

# Configure auditing
auditpol /set /subcategory:"$subcategory" /success:enable /failure:disable | Out-Null

# Verify configuration
$auditStatus = auditpol /get /subcategory:"$subcategory"

if ($auditStatus -match "Success") {
    Write-Host "Compliant: 'Audit File System' is enabled for Success events."
} else {
    Write-Host "Non-Compliant: Failed to enable 'Audit File System' for Success events."
}
