VaultAWS – Cloud Security Baseline & SOC Pipeline

VaultAWS is a security-focused AWS environment built using Terraform.  
The project demonstrates how I designed, secured, monitored, and how to respond to security events in a cloud environment.

Key Features

Secure VPC with public and private subnets
Centralised logging using CloudTrail and AWS Config
Encrypted S3 log storage with strict access controls
IAM role separation (break-glass, deployment, audit)
Explicit deny guardrails to protect security controls
Real-time security alerts using CloudWatch and SNS
SOC dashboard for visibility
Incident response runbook

Security Monitoring

Root account usage
Failed console login attempts
IAM policy and access key changes
Security groups opened to the internet
Attempts to disable logging or configuration tracking

Infrastructure as Code
All infrastructure is deployed and managed using Terraform

modules/ reusable Terraform modules
accounts/dev/ environment configuration
runbooks/ SOC response procedures


