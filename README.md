## 📌 Task 1 – Networking & Subnetting (AWS VPC Setup)
🛠️ What I Built

I designed a basic AWS network architecture consisting of:

1 VPC with CIDR 10.0.0.0/16

2 Public Subnets

10.0.1.0/24

10.0.2.0/24

2 Private Subnets

10.0.3.0/24

10.0.4.0/24

Internet Gateway (IGW) for public subnet internet access

NAT Gateway placed in public subnet to allow outbound access from private instances

🧠 Why I Chose These Ranges

I kept the VPC CIDR large (/16) for future expansion and divided it into /24 ranges for subnet isolation, making IP planning simple and scalable.
Two AZs were used to improve reliability.

📸 Required Screenshots

✔ VPC
✔ Subnets
✔ Route Tables (Public + Private)
✔ NAT Gateway & Internet Gateway

📂 Code Repository

Terraform code for Task 1:
➡️ Add your GitHub link here

## 📌 Task 2 – EC2 Static Resume Website Hosting
🛠️ What I Built

Launched a Free Tier EC2 instance in the public subnet

Installed and configured Nginx using user_data

Deployed a static HTML resume website

Ensured the site is publicly accessible over HTTP (port 80)

Added basic hardening:

Only allowed necessary ports (80, 22)

Using security groups with least privilege

Disabled unnecessary packages and services

📸 Required Screenshots

✔ EC2 Instance page
✔ Security Group
✔ Website loading in browser

📂 Code Repository

Terraform code & HTML resume file:
➡️ Add your GitHub link here

## 📌 Task 3 – High Availability + Auto Scaling
🛠️ What I Built

I upgraded the infrastructure into a Highly Available Architecture:

Application Load Balancer (ALB) deployed in public subnets

EC2 moved to private subnets for better security

Auto Scaling Group (ASG) configured to run 2–3 instances

Launch Template to automate EC2 configuration

Traffic Flow:
Client → ALB → Private Subnets → EC2 instances (ASG)

This ensures:

High Availability

Scalability

Better security by isolating compute resources

📸 Required Screenshots

✔ ALB configuration
✔ Target Group health
✔ Auto Scaling Group details
✔ EC2 instances launched by ASG

📂 Code Repository

Terraform code for ALB + ASG:
➡️ Add your GitHub link here

## 📌 Task 4 – Billing & Free Tier Cost Monitoring
🛠️ What I Configured

CloudWatch Billing Alarm at ₹100 to avoid unexpected charges

Enabled AWS Free Tier Usage Alerts

🧠 Why Cost Monitoring is Important

Beginners often leave EC2, NAT Gateways, or EBS volumes running

NAT Gateways & Data Transfer are the most common sources of sudden bill spikes

Cost alerts prevent overspending by sending notifications before usage exceeds limits

📸 Required Screenshots

✔ Billing Alarm
✔ Free Tier Usage Alerts page

## 📌 Task 5 – Architecture Diagram (draw.io)
🖼️ Architecture Requirements

Designed a scalable architecture capable of handling 10,000+ concurrent users including:

Application Load Balancer (ALB)

Auto Scaling Group (multi-AZ)

Public & Private Subnets

RDS / Aurora Multi-AZ Database Layer

ElastiCache (Redis) for performance optimization

Security Groups, NACLs, IAM roles

CloudWatch monitoring & logs

Optional: WAF, CloudFront

📂 Deliverable

✔ draw.io exported PNG/PDF
✔ Architecture Diagram included in repo

✔ Final Notes

This project demonstrates:

AWS Networking

EC2 deployment

Infrastructure as Code (Terraform)

High Availability Architecture

Monitoring & Cost Alerts

Real-world cloud design principles
