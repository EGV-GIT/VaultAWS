# VaultAWS SOC Runbook

Response steps for common security alerts.

---

## Root Account Activity
**Severity:** Critical

1. Review the CloudTrail event — identify the action, time, and source IP
2. Confirm whether the activity was authorised
3. If unexpected: revoke active sessions, enable MFA if not already on, notify the team

---

## Console Login Failures
**Severity:** High

1. Identify the user and source IP from CloudTrail
2. Check for repeated attempts or unusual geography
3. Rotate credentials and confirm MFA is enforced

---

## IAM Policy Changes
**Severity:** High

1. Review the change in CloudTrail (`PutRolePolicy`, `AttachRolePolicy`, etc.)
2. Confirm the change was approved and follows least privilege
3. Revert and escalate if unauthorised

---

## Access Key Creation
**Severity:** Medium

1. Identify the key owner and the IAM entity that created it
2. Confirm there is a legitimate business need
3. Remove the key if unnecessary; enforce rotation policy

---

## Security Group Open to Internet
**Severity:** High

1. Identify the affected security group and the rule added
2. Remove `0.0.0.0/0` or `::/0` ingress if not explicitly required
3. Document the decision and notify the team

---

## CloudTrail or AWS Config Tampered
**Severity:** Critical

1. Review the attempted change in CloudTrail
2. Confirm guardrails blocked the action (check `DenyDisableCloudTrail` / `DenyDisableConfig` policy)
3. Escalate immediately if the action succeeded

---

## Notes

- Log all incidents with timestamp, responder, and outcome
- Escalate when unsure — false positives are cheaper than missed incidents
- Follow least privilege at all times
