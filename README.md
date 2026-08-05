# 🐳 DockWatch

> **Docker Infrastructure Monitoring, Security & Recovery Dashboard**

![DockWatch Architecture](image.png)

DockWatch is an open-source DevOps project that helps monitor, analyze, secure, and recover Docker environments from a single dashboard. It automates routine Docker administration tasks by providing resource analysis, health monitoring, security auditing, and recovery suggestions.

# ✨ Features

## 📦 Inventory
- Scan Docker containers
- List Docker images
- List Docker volumes
- List Docker networks
- View Docker environment summary

## 📊 Monitoring
- Container CPU usage
- Memory usage
- Disk usage
- Running container statistics
- Live Docker resource monitoring

## 📈 Analyzer
- Docker health score
- Risk level detection
- Resource analysis
- Optimization recommendations
- Unused Docker objects detection

## 🔒 Security
- Detect privileged containers
- Detect root user containers
- Detect exposed ports
- Docker security summary

## 🔄 Recovery
- Detect stopped containers
- Restart failed containers
- Recovery report generation
- Suggested recovery commands

## 🌐 Web Dashboard
- Flask-based dashboard
- Responsive UI
- Live module integration
- Modern dark theme
- Interactive cards and statistics

---

# 🏗 Project Structure

```text
DockWatch/
│
├── analyzer/
├── dashboard/
├── docs/
├── inventory/
├── monitor/
├── recovery/
├── security/
├── web/
│
├── README.md
└── image.png
```
---
# ⚙ Tech Stack

|--------------------------------------|
| Technology | Usage                   |
|------------|-------------------------|
| Python     | Backend                 |
| Flask      | Web Dashboard           |
| Bash       | Docker Automation       |
| HTML       | Frontend                |
| CSS        | Styling                 |
| JavaScript | Dashboard Logic         |
| Docker     | Container Platform      |
| Ubuntu     | Development Environment |
| Git        | Version Control         |
| GitHub     | Repository Hosting      |
|--------------------------------------|

---

# 🚀 Installation

Clone the repository

```bash
git clone https://github.com/Sunaina-Kasera/DockWatch.git
```
Move inside project

```bash
cd DockWatch
```
Install Python dependencies

```bash
pip install -r requirements.txt
```
Run Dashboard

```bash
python app.py
```
Open browser

```
http://127.0.0.1:5000
```
---

# 📋 Modules

|  Module   |      Description         |
|-----------|--------------------------|
| Inventory | Docker inventory scanner |
| Monitor   | Resource monitoring      |
| Analyzer  | Docker health analysis   |
| Security  | Docker security auditing |
| Recovery  | Container recovery       |
| Dashboard | Flask web interface      |

---

# 🎯 Future Enhancements

- AWS Deployment
- Kubernetes Support
- Prometheus Integration
- Grafana Dashboard
- Email Notifications
- Slack Notifications
- Discord Alerts
- Telegram Alerts
- Docker Swarm Support

---

# 👩‍💻 Author

**Sunaina Kasera**

Aspiring DevOps Engineer passionate about Linux, Docker, Cloud and Automation.

GitHub:
https://github.com/Sunaina-Kasera

---