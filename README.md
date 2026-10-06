# 🔐 Windows Failed Login Detector

A Windows security monitoring lab that detects failed login attempts using **Windows Event Viewer, PowerShell, and Task Scheduler**.

## 🎯 Objective

Build a lightweight intrusion-detection system that:

* Detects failed Windows login attempts
* Monitors **Event ID 4625**
* Records security events as evidence
* Captures a screenshot when an event occurs
* Provides a notification after the defined threshold
* Automatically runs through Windows Task Scheduler

## 🛠️ Technologies

* Windows Event Viewer
* PowerShell
* Windows Security Logs
* Task Scheduler
* Event ID 4625 — Failed Logon
* Event ID 4624 — Successful Logon

## 🔎 How It Works

```text
Failed Login
     ↓
Windows Security Log
     ↓
Event ID 4625
     ↓
PowerShell Detector
     ↓
Evidence Collection
     ↓
Screenshot / Notification
     ↓
Task Scheduler Automation
```

## 🧪 What I Learned

* How Windows records authentication events
* How to investigate failed login attempts
* How to filter Windows Security logs
* How PowerShell can automate security monitoring
* How to collect basic endpoint evidence
* How Task Scheduler can automate detection scripts

## 📸 Lab Evidence

Screenshots demonstrating the Event Viewer logs, detector, evidence collection, and automated task execution are included in the `screenshots` directory.

## 🚀 Future Improvements

* Add email or Teams notifications
* Track repeated attempts by source
* Add IP/user correlation where available
* Create a dashboard for authentication events
* Forward events to a SIEM such as Wazuh or Splunk
