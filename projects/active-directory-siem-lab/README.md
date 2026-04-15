# Active Directory Tiered Security Lab with Wazuh SIEM

A home lab simulating an enterprise-grade Active Directory environment with tiered privilege separation, GPO security hardening, and Wazuh SIEM integration for real-time threat detection and monitoring.

> **Status:** Complete — Wazuh agent active, MITRE ATT&CK detections confirmed

---

## Architecture

```
┌─────────────────────────────────┐     ┌──────────────────────────────────┐
│   Desktop PC                    │     │   Laptop (VirtualBox)            │
│   Ubuntu 24.04                  │     │   Windows Server 2022            │
│   Wazuh SIEM Server             │     │   Active Directory               │
│   IP: 172.20.10.10              │     │   soclab.local                   │
│                                 │     │   Wazuh Agent                    │
│   • Wazuh Manager               │     │   IP: 172.20.10.11               │
│   • Wazuh Indexer               │     │                                  │
│   • Wazuh Dashboard             │     │   T0 / T1 / T2 OU Structure      │
└─────────────────────────────────┘     └──────────────────────────────────┘
              │                                        │
              └──────────── 172.20.10.x ───────────────┘
                         Home Network
```

---

## Lab Components

| Component | Details |
|---|---|
| SIEM Server | Ubuntu 24.04 desktop — Wazuh 4.14.4 all-in-one |
| Domain Controller | Windows Server 2022 — VirtualBox on laptop |
| Domain Name | soclab.local |
| Agent Status | Active — events flowing to dashboard |

---

## Project Phases

- [x] Phase 1 — Active Directory setup and tiered OU structure
- [x] Phase 2 — GPO hardening (T0/T1/T2 security baselines)
- [x] Phase 3 — Wazuh SIEM deployment on Ubuntu desktop
- [x] Phase 4 — Windows Server agent integration
- [ ] Phase 5 — Attack simulation and detection (Kali Linux)

---

## MITRE ATT&CK Detections

Events detected immediately after agent connection:

| Tactic | Events |
|---|---|
| Defense Evasion | 119 |
| Privilege Escalation | 119 |
| Initial Access | 114 |

---

## Documentation

1. [Active Directory Setup](docs/1-ad-setup.md)
2. [GPO Hardening](docs/2-gpo-hardening.md)
3. [Wazuh Installation](docs/3-wazuh-install.md)
4. [Agent Configuration](docs/4-agent-config.md)
5. [Attack Simulation](docs/5-attack-simulation.md) — Coming Soon

---

## Key Security Concepts Demonstrated

- **Tiered Administration Model** — T0/T1/T2 privilege separation prevents lateral movement
- **GPO Security Baselines** — enforcing security policy at scale via Group Policy
- **SIEM Log Collection** — centralised security event monitoring across the domain
- **MITRE ATT&CK Mapping** — real-time tactic identification from Windows event logs
- **Audit Policy** — capturing logon events, privilege use, and policy changes
