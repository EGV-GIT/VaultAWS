resource "aws_sns_topic" "security_alerts" {
  name = "${var.project_name}-security-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  count     = var.alert_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_log_metric_filter" "root_activity" {
  name           = "${var.project_name}-RootActivity"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.userIdentity.type = \"Root\") && ($.eventType != \"AwsServiceEvent\") }"

  metric_transformation {
    name      = "RootActivityCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_activity_alarm" {
  alarm_name          = "${var.project_name}-RootActivityAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "RootActivityCount"
  namespace           = var.project_name
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_cloudwatch_log_metric_filter" "console_login_failure" {
  name           = "${var.project_name}-ConsoleLoginFailure"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.errorMessage = \"Failed authentication\") }"

  metric_transformation {
    name      = "ConsoleLoginFailureCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_login_failure_alarm" {
  alarm_name          = "${var.project_name}-ConsoleLoginFailureAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsoleLoginFailureCount"
  namespace           = var.project_name
  period              = 300
  statistic           = "Sum"
  threshold           = 3

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_cloudwatch_log_metric_filter" "access_key_created" {
  name           = "${var.project_name}-AccessKeyCreated"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.eventSource = \"iam.amazonaws.com\") && ($.eventName = \"CreateAccessKey\") }"

  metric_transformation {
    name      = "AccessKeyCreatedCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "access_key_created_alarm" {
  alarm_name          = "${var.project_name}-AccessKeyCreatedAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "AccessKeyCreatedCount"
  namespace           = var.project_name
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_cloudwatch_log_metric_filter" "iam_policy_changes" {
  name           = "${var.project_name}-IamPolicyChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.eventSource = \"iam.amazonaws.com\") && (($.eventName = \"PutUserPolicy\") || ($.eventName = \"PutRolePolicy\") || ($.eventName = \"AttachUserPolicy\") || ($.eventName = \"AttachRolePolicy\") || ($.eventName = \"CreatePolicy\") || ($.eventName = \"CreatePolicyVersion\") || ($.eventName = \"SetDefaultPolicyVersion\")) }"

  metric_transformation {
    name      = "IamPolicyChangesCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "iam_policy_changes_alarm" {
  alarm_name          = "${var.project_name}-IamPolicyChangesAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "IamPolicyChangesCount"
  namespace           = var.project_name
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_cloudwatch_log_metric_filter" "security_group_open_world" {
  name           = "${var.project_name}-SecurityGroupOpenWorld"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.eventSource = \"ec2.amazonaws.com\") && (($.eventName = \"AuthorizeSecurityGroupIngress\") || ($.eventName = \"AuthorizeSecurityGroupEgress\")) && ($.requestParameters.ipPermissions.items[0].ipRanges.items[0].cidrIp = \"0.0.0.0/0\") }"

  metric_transformation {
    name      = "SecurityGroupOpenWorldCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "security_group_open_world_alarm" {
  alarm_name          = "${var.project_name}-SecurityGroupOpenWorldAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "SecurityGroupOpenWorldCount"
  namespace           = var.project_name
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_changes" {
  name           = "${var.project_name}-CloudTrailChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.eventSource = \"cloudtrail.amazonaws.com\") && (($.eventName = \"StopLogging\") || ($.eventName = \"DeleteTrail\") || ($.eventName = \"UpdateTrail\")) }"

  metric_transformation {
    name      = "CloudTrailChangesCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail_changes_alarm" {
  alarm_name          = "${var.project_name}-CloudTrailChangesAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CloudTrailChangesCount"
  namespace           = var.project_name
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_cloudwatch_log_metric_filter" "config_changes" {
  name           = "${var.project_name}-ConfigChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "{ ($.eventSource = \"config.amazonaws.com\") && (($.eventName = \"StopConfigurationRecorder\") || ($.eventName = \"DeleteConfigurationRecorder\") || ($.eventName = \"DeleteDeliveryChannel\") || ($.eventName = \"PutDeliveryChannel\") || ($.eventName = \"PutConfigurationRecorder\")) }"

  metric_transformation {
    name      = "ConfigChangesCount"
    namespace = var.project_name
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "config_changes_alarm" {
  alarm_name          = "${var.project_name}-ConfigChangesAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConfigChangesCount"
  namespace           = var.project_name
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}


