# gpo-setup.ps1
# Active Directory GPO Hardening Script
# Domain: soclab.local
# Author: Shemmy Afolayan
# Description: Applies security baseline settings to tiered GPOs

# ============================================================
# VERIFY GPOs EXIST
# ============================================================
Write-Host "`n[*] Checking existing GPOs..." -ForegroundColor Cyan
Get-GPO -All | Select-Object DisplayName, GpoStatus

# ============================================================
# CHECK GPO INHERITANCE ON DOMAIN CONTROLLERS OU
# ============================================================
Write-Host "`n[*] Checking GPO inheritance on Domain Controllers OU..." -ForegroundColor Cyan
Get-GPInheritance -Target "OU=Domain Controllers,DC=soclab,DC=local"

# ============================================================
# T0-SECURITY-BASELINE SETTINGS
# ============================================================
Write-Host "`n[*] Applying T0-Security-Baseline settings..." -ForegroundColor Cyan

# Require Ctrl+Alt+Del at login
Set-GPRegistryValue -Name "T0-Security-Baseline" `
    -Key "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "DisableCAD" `
    -Type DWord `
    -Value 0

# Grant Domain Controllers apply permission
Set-GPPermission -Name "T0-Security-Baseline" `
    -TargetName "Domain Controllers" `
    -TargetType Group `
    -PermissionLevel GpoApply

Write-Host "[+] T0-Security-Baseline configured" -ForegroundColor Green

# ============================================================
# GPO-T1-SERVER-SECURITY SETTINGS
# ============================================================
Write-Host "`n[*] Applying GPO-T1-Server-Security settings..." -ForegroundColor Cyan

# Require Ctrl+Alt+Del at login
Set-GPRegistryValue -Name "GPO-T1-Server-Security" `
    -Key "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "DisableCAD" `
    -Type DWord `
    -Value 0

# Block blank passwords over network
Set-GPRegistryValue -Name "GPO-T1-Server-Security" `
    -Key "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa" `
    -ValueName "LimitBlankPasswordUse" `
    -Type DWord `
    -Value 1

# Grant Domain Controllers apply permission
Set-GPPermission -Name "GPO-T1-Server-Security" `
    -TargetName "Domain Controllers" `
    -TargetType Group `
    -PermissionLevel GpoApply

Write-Host "[+] GPO-T1-Server-Security configured" -ForegroundColor Green

# ============================================================
# T2-WORKSTATION-SECURITY SETTINGS
# ============================================================
Write-Host "`n[*] Applying T2-Workstation-Security settings..." -ForegroundColor Cyan

# Grant Domain Computers apply permission
Set-GPPermission -Name "T2-Workstation-Security" `
    -TargetName "Domain Computers" `
    -TargetType Group `
    -PermissionLevel GpoApply

Write-Host "[+] T2-Workstation-Security configured" -ForegroundColor Green

# ============================================================
# LINK GPOs TO OUs
# ============================================================
Write-Host "`n[*] Linking GPOs to OUs..." -ForegroundColor Cyan

# Link T1 Server GPO to Domain Controllers OU
New-GPLink -Name "GPO-T1-Server-Security" `
    -Target "OU=Domain Controllers,DC=soclab,DC=local" `
    -ErrorAction SilentlyContinue

# Link T0 Baseline to root domain
New-GPLink -Name "T0-Security-Baseline" `
    -Target "DC=soclab,DC=local" `
    -ErrorAction SilentlyContinue

Write-Host "[+] GPO links configured" -ForegroundColor Green

# ============================================================
# FORCE POLICY UPDATE AND VERIFY
# ============================================================
Write-Host "`n[*] Forcing Group Policy update..." -ForegroundColor Cyan
gpupdate /force

Write-Host "`n[*] Verifying applied GPOs..." -ForegroundColor Cyan
gpresult /r /scope computer

Write-Host "`n[+] GPO hardening complete." -ForegroundColor Green
