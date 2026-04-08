# Phase 2 — GPO Hardening

## Overview

Security baseline policies applied to each tier via Group Policy. Settings align with industry-standard hardening frameworks including CIS Benchmarks and Microsoft Security Baselines.

---

## Default Domain Policy — Password & Account Settings

Applied to entire domain via root-level link.

| Setting | Value | Rationale |
|---|---|---|
| Minimum Password Length | 7 characters | Prevents trivial passwords |
| Password Complexity | Enabled | Requires mixed character types |
| Maximum Password Age | 42 days | Forces regular rotation |
| Minimum Password Age | 1 day | Prevents immediate reuse |
| Password History | 24 passwords | Prevents recycling old passwords |
| Clear Text Password | Disabled | Prevents LM hash storage |
| Max Clock Skew (Kerberos) | 5 minutes | Standard Kerberos tolerance |
| Max Ticket Age | 10 hours | Limits Kerberos ticket lifetime |

---

## T0-Security-Baseline

Applied to domain root — inherited by all OUs.

| Setting | Registry Key | Value | Rationale |
|---|---|---|---|
| Require Ctrl+Alt+Del | HKLM\...\Policies\System\DisableCAD | 0 | Prevents credential harvesting via fake login screens |

### Commands Used

```powershell
Set-GPRegistryValue -Name "T0-Security-Baseline" `
  -Key "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName "DisableCAD" `
  -Type DWord `
  -Value 0

Set-GPPermission -Name "T0-Security-Baseline" `
  -TargetName "Domain Controllers" `
  -TargetType Group `
  -PermissionLevel GpoApply
```

---

## GPO-T1-Server-Security

Applied to Domain Controllers OU — targets DC and server tier.

| Setting | Registry Key | Value | Rationale |
|---|---|---|---|
| Require Ctrl+Alt+Del | HKLM\...\Policies\System\DisableCAD | 0 | Secure attention sequence at login |
| Limit blank password use | HKLM\System\...\Lsa\LimitBlankPasswordUse | 1 | Blocks blank passwords over network |

### Commands Used

```powershell
Set-GPRegistryValue -Name "GPO-T1-Server-Security" `
  -Key "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName "DisableCAD" `
  -Type DWord `
  -Value 0

Set-GPPermission -Name "GPO-T1-Server-Security" `
  -TargetName "Domain Controllers" `
  -TargetType Group `
  -PermissionLevel GpoApply
```

---

## Verification Commands

```powershell
# Check all GPOs exist
Get-GPO -All

# Check what's linked to Domain Controllers OU
Get-GPInheritance -Target "OU=Domain Controllers,DC=soclab,DC=local"

# Verify GPOs are actually applying
gpresult /r /scope computer

# Check GPO has settings configured
(Get-GPOReport -Name "GPO-T1-Server-Security" -ReportType XML) | Select-String "ExtensionData"
```

---

## Troubleshooting Log

| Issue | Cause | Resolution |
|---|---|---|
| GPOs not in Applied list | GPOs were empty shells | Added settings via Set-GPRegistryValue |
| Filtering: Denied (Security) | Computer account lacked Apply permission | Used Set-GPPermission to grant GpoApply to Domain Controllers group |
| GPOs linked but not applying | gpresult showed stale cache | Ran gpupdate /force then re-checked |

---

## Next Steps

- Add account lockout policy (lockout after 5 failed attempts)
- Disable LLMNR and NBT-NS via GPO (common attack vectors)
- Enable advanced audit policy for logon events, privilege use, object access
- These audit events will feed into Wazuh SIEM for alert generation
