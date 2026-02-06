🔐 Container Security Scanning with Trivy

This lab demonstrates how to scan, analyze, and harden Docker container images using **Trivy**, an open-source vulnerability scanner by Aqua Security.

The goal was to identify security risks in a vulnerable container image and reduce them by applying container hardening best practices.

🎯 Objectives

- Install and configure Trivy
- Scan public and custom Docker images
- Identify vulnerabilities by severity
- Compare vulnerable vs hardened images
- Generate security reports
- Simulate CI/CD security gates

🧰 Tools Used

- Docker
- Trivy
- Linux / WSL
- Python (sample app)

📦 Project Structure

<img width="405" height="285" alt="image" src="https://github.com/user-attachments/assets/429136bc-93bb-4d6f-8836-5684d67deaec" />  

🚨 Vulnerable Image

### Base Image
ubuntu:18.04

### Issues Introduced

- Outdated OS (EOL)
- Large attack surface
- Multiple unnecessary packages
- Runs as root user

### Build Command
docker build -t vulnerable-app:v1 .

Scan Command
trivy image vulnerable-app:v1

🛡️ Hardened Image
Security Improvements

Minimal base image (Alpine)

Reduced package installation

Non-root user

Smaller attack surface

Base Image
python:3.11-alpine

Build Command
docker build -t hardened-app:v1 -f Dockerfile.secure .

Scan Command
trivy image hardened-app:v1

📊 Vulnerability Comparison 

<img width="1010" height="234" alt="image" src="https://github.com/user-attachments/assets/c97d7e89-c202-4c62-b5d0-e4f68c324982" />


📑 Severity Filtering

Scan only high-risk issues:

trivy image --severity HIGH,CRITICAL vulnerable-app:v1

📄 Report Generation
JSON Report
trivy image -f json -o report.json vulnerable-app:v1

Table Report
trivy image -f table -o report.txt vulnerable-app:v1

🔁 CI/CD Security Gate Simulation

Fail pipeline if critical vulnerabilities exist:
trivy image --exit-code 1 --severity CRITICAL vulnerable-app:v1
echo $?

Exit Codes:
0 → Pass
1 → Fail

🔍 Filesystem Secret Scan
trivy fs /etc
Detected:
Private key exposure risk

⚙️ Automation Script

Example scan script:
#!/bin/bash
IMAGE=$1
trivy image --severity HIGH,CRITICAL $IMAGE
if [ $? -eq 0 ]; then
  echo "Image Passed Security Scan"
else
  echo "Image Failed Security Scan"
fi

Run:
chmod +x scan.sh
./scan.sh hardened-app:v1

