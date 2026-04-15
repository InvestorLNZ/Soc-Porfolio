# Phase 3 — Wazuh SIEM Installation

## Overview

Wazuh deployed on a dedicated Ubuntu 24.04 desktop machine acting as the SIEM server. The all-in-one installer was used to deploy the full Wazuh stack — manager, indexer, and dashboard — in a single installation.

---

## Lab Architecture

```
┌─────────────────────────────────┐     ┌──────────────────────────────────┐
│   Desktop PC                    │     │   Laptop                         │
│   Ubuntu 24.04                  │     │   VirtualBox                     │
│   Wazuh SIEM Server             │     │   Windows Server 2022 VM         │
│   IP: 172.20.10.10              │     │   Active Directory (soclab.local)│
│                                 │     │   Wazuh Agent                    │
│                                 │     │   IP: 172.20.10.11               │
└─────────────────────────────────┘     └──────────────────────────────────┘
              │                                        │
              └──────────── 172.20.10.x ───────────────┘
                         Home Network
```

---

## Wazuh Components Installed

| Component | Purpose |
|---|---|
| Wazuh Manager | Receives and processes security events from agents |
| Wazuh Indexer | Stores and indexes security events (OpenSearch-based) |
| Wazuh Dashboard | Web UI for alert analysis and visualisation |

---

## Installation

### System Specs
- OS: Ubuntu 24.04 LTS
- RAM: 2GB
- Wazuh Version: 4.14.4

### Commands Used

```bash
# Download installer
curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh

# Run all-in-one installation
sudo bash wazuh-install.sh -a -i
```

The `-a` flag installs all components. The `-i` flag ignores the OS compatibility check (required for Ubuntu 24.04).

Installation takes approximately 10-15 minutes. On completion the installer outputs admin credentials — these were saved securely.

### Retrieve Credentials (if not saved)

```bash
sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
```

---

## Accessing the Dashboard

Open a browser and navigate to:

```
https://172.20.10.10
```

Accept the self-signed certificate warning and log in with the admin credentials generated during installation.

---

## Service Management

```bash
# Check all Wazuh services
sudo /var/ossec/bin/wazuh-control status

# Restart all services
sudo /var/ossec/bin/wazuh-control restart

# Check listening ports
sudo ss -tlnp | grep -E "1514|1515|443|55000"
```

### Key Ports

| Port | Service | Purpose |
|---|---|---|
| 443 | Wazuh Dashboard | Web UI access |
| 1514 | Wazuh Remoted | Agent event collection |
| 1515 | Wazuh Authd | Agent registration |
| 55000 | Wazuh API | REST API |

---

## Issues Encountered

**Ubuntu 24.04 compatibility warning** — Wazuh 4.7 officially supports Ubuntu 22.04. Running on 24.04 triggered a compatibility warning during install. Resolved by using the `-i` flag to ignore the check. All services ran successfully.

**wazuh-clusterd not running** — Expected for single-node deployments. Clustering is only required for multi-node Wazuh setups. Not an issue for this lab.
