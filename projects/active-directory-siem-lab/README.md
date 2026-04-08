# Active Directory Tiered Security Lab

A home lab simulating an enterprise-grade Active Directory environment with tiered privilege separation, GPO security hardening, and Wazuh SIEM integration for threat detection and monitoring.

> **Status:** In Progress — GPO hardening complete, Wazuh deployment in progress

---

## Architecture

```
┌─────────────────────────────────────────┐
│           soclab.local Domain           │
│                                         │
│  ┌─────────────┐    ┌─────────────┐    │
│  │  Tier 0     │    │  Tier 1     │    │
│  │  Domain     │    │  Servers    │    │
│  │  Controllers│    │             │    │
│  └─────────────┘    └─────────────┘    │
│                                         │
│  ┌─────────────┐                        │
│  │  Tier 2     │                        │
│  │  Workstations│                       │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
              │
              │ Wazuh Agent (logs)
              ▼
┌─────────────────────────────────────────┐
│         AWS EC2 — Wazuh SIEM            │
│         Ubuntu 22.04                    │
│         Wazuh Manager + Dashboard       │
└─────────────────────────────────────────┘
```

---

## Lab Components

| Component | Details |
|---|---|
| Hypervisor | VirtualBox (local) |
| Domain Controller | Windows Server 2022 |
| Domain Name | soclab.local |
| SIEM | Wazuh (AWS EC2 — Ubuntu 22.04) |
| Scripting | PowerShell |

---

## Project Phases

- [x] Phase 1 — Active Directory setup and tiered OU structure
- [x] Phase 2 — GPO hardening (T0/T1/T2 security baselines)
- [ ] Phase 3 — Wazuh SIEM deployment on AWS
- [ ] Phase 4 — Windows Server agent integration
- [ ] Phase 5 — Attack simulation and detection

---

## Documentation

1. [Active Directory Setup](docs/1-ad-setup.md)
2. [GPO Hardening](docs/2-gpo-hardening.md)
3. [Wazuh Installation](docs/3-wazuh-install.md)
4. [Agent Configuration](docs/4-agent-config.md)
5. [Attack Simulation](docs/5-attack-simulation.md)

---

## Key Security Concepts Demonstrated

- **Tiered Administration Model** — separating privileged access by tier prevents lateral movement across privilege boundaries
- **GPO Security Baselines** — enforcing security settings at scale via Group Policy
- **Least Privilege Networking** — AWS security groups locked to specific IPs and ports only
- **SIEM Log Collection** — centralised security event monitoring across the domain
- **Audit Policy** — capturing logon events, privilege use, and policy changes for forensic analysis
