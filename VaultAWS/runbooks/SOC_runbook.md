VaultAWS SOC Runbook

This runbook provides basic response steps for common security alerts in my VaultAWS environment.

---

Root Account Activity  
Severity: Critical  
1. Review the CloudTrail event details  
2. Confirm if the activity was authorised  
3. Secure the root account if unexpected and notify the team  

---

Console Login Failures  
Severity: High  
1. Identify the user and source IP  
2. Check for repeated or suspicious attempts  
3. Rotate credentials and ensure MFA is enabled if required  

---

IAM Policy Changes  
Severity: High  
1. Review the policy change in CloudTrail  
2. Confirm the change was approved  
3. Revert and escalate if unauthorised  

---

Access Key Creation  
Severity: Medium  
1. Identify the key owner  
2. Confirm business need  
3. Remove unused or unnecessary keys  

---

Security Group Open to Internet  
Severity: High  
1. Identify the affected security group  
2. Remove `0.0.0.0/0` access if not required  
3. Notify the team  

---

CloudTrail or AWS Config Changes  
Severity: Critical  
1. Review the attempted change  
2. Confirm guardrails blocked the action  
3. Escalate immediately if suspicious  

---

Notes  
1. Log all incidents  
2. Escalate when unsure  
3. Follow least privilege principles  
