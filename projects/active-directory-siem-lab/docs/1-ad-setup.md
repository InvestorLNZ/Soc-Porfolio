# Phase 1 — Active Directory Setup

## Overview

Windows Server 2022 deployed in VirtualBox as a Domain Controller for the `soclab.local` domain. The domain is structured using a tiered administration model — a security pattern used in enterprise environments to contain the blast radius of credential compromise.

---

## Tiered Administration Model

The core principle: **credentials from a lower tier must never touch a higher tier.**

| Tier | Scope | Assets |
|---|---|---|
| T0 | Highest privilege | Domain Controllers, AD infrastructure |
| T1 | Server privilege | Member servers, applications |
| T2 | Workstation privilege | End-user machines |

If an attacker compromises a T2 workstation, they cannot use those credentials to pivot to T1 servers or T0 domain controllers. Each tier is a security boundary.

---

## Domain Configuration

| Setting | Value |
|---|---|
| Domain Name | soclab.local |
| NetBIOS Name | SOCLAB |
| Forest/Domain Functional Level | Windows Server 2016 |
| Domain Controller hostname | WIN-I1I18JLE63S |

---

## OU Structure

```
soclab.local
├── Domain Controllers          ← Default DC container
├── Tier-0                      ← Privileged identity assets
├── Tier-1                      ← Server workloads
└── Tier-2                      ← Workstations
```

Each OU acts as the scope for its corresponding GPO — policies only apply to computers inside the linked OU.

---

## GPOs Created

| GPO Name | Linked To | Purpose |
|---|---|---|
| T0-Security-Baseline | soclab.local (root) | Domain-wide baseline |
| GPO-T1-Server-Security | OU=Domain Controllers | DC and server hardening |
| T2-Workstation-Security | OU=Tier-2 | Workstation hardening |
| Default Domain Policy | soclab.local | Password and account policy |
| Default Domain Controllers Policy | Domain Controllers OU | Default DC settings |

---

## Verification

GPO application verified using `gpresult /r /scope computer` on the Domain Controller.

**Applied GPOs confirmed:**
- Default Domain Controllers Policy ✅
- GPO-T1-Server-Security ✅
- Default Domain Policy ✅
- TO-Security-Baseline ✅

GPO inheritance verified using:
```powershell
Get-GPInheritance -Target "OU=Domain Controllers,DC=soclab,DC=local"
```

---

## Issues Encountered

**GPOs not applying initially** — GPOs were created and linked but had no settings configured inside them. Windows filters out empty GPOs silently. Resolution: added registry-based security settings to each GPO using `Set-GPRegistryValue`.

**Security filtering blocking application** — GPOs were linked but `gpresult` showed `Filtering: Denied (Security)`. Resolution: explicitly granted `GpoApply` permission to `Domain Controllers` group using `Set-GPPermission`.

These are real-world GPO troubleshooting scenarios that commonly occur in enterprise environments.
