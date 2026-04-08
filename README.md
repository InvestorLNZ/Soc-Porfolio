# SOC Portfolio — Shemmy Afolayan

BSc Cyber Security (First Class Honours) — York St John University  
📍 Gravesend, Kent | 🔗 [LinkedIn](https://linkedin.com/in/shemmy-afolayan) | 🐙 [GitHub](https://github.com/InvestorLNZ)

---

## About

This repository documents my hands-on cybersecurity projects, built to develop and evidence practical skills in defensive security engineering, SIEM deployment, Active Directory hardening, and IoT security.

Each project reflects real-world security patterns and is documented end-to-end — from design decisions through to implementation, testing, and lessons learned.

---

## Projects

### 1. Active Directory Tiered Security Lab
**Status:** In Progress  
**Focus:** Enterprise AD hardening, GPO security baselines, SIEM integration, threat detection

A tiered Active Directory environment built on Windows Server, implementing a T0/T1/T2 privilege model with CIS-aligned Group Policy hardening. Wazuh SIEM deployed on AWS to collect and analyse security events from the domain controller.

**Key technologies:** Windows Server, Active Directory, Group Policy, PowerShell, Wazuh, Ubuntu, AWS EC2

[View Project →](projects/active-directory-siem-lab/README.md)

---

### 2. IoT Smart Home Intrusion Detection System
**Status:** Complete  
**Focus:** IoT security, MQTT, Python automation, secure credential handling, real-time alerting

An end-to-end IoT security alerting system built with Arduino UNO R4 WiFi and Raspberry Pi. Detects motion via PIR sensor and delivers real-time Telegram notifications over a secure MQTT pipeline. Built with security-first design including credential separation and encrypted alert delivery.

**Key technologies:** Arduino, Raspberry Pi, Python, MQTT, Telegram Bot API, ThingSpeak

[View Project →](projects/iot-intrusion-detection/README.md)

---

## Skills Evidenced

| Area | Evidence |
|---|---|
| SIEM Deployment | Wazuh on AWS, Windows agent integration |
| Active Directory | Tiered OU structure, GPO hardening, PowerShell automation |
| Cloud Security | AWS VPC, security groups, least-privilege networking |
| IoT Security | MQTT pipeline, credential management, encrypted alerting |
| Python | MQTT subscriber, Telegram API integration, automation scripts |
| Linux | Ubuntu server administration, UFW firewall, SSH hardening |
| Documentation | End-to-end technical writeups with architecture diagrams |

---

## Certifications

- Microsoft AZ-900 ✅
- CompTIA Security+ — In Progress
- CompTIA CySA+ — In Progress

---

## Currently Building

- Wazuh SIEM agent integration with Windows Server DC
- Attack simulation and detection documentation
- CIS Benchmark GPO policies for T0/T1/T2 tiers
