resource "aws_cloudwatch_dashboard" "soc" {
  dashboard_name = "${var.project_name}-SOC-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 12
        height = 6
        properties = {
          title = "Root Account Activity"
          metrics = [
            [ var.project_name, "RootActivityCount" ]
          ]
          period = 300
          stat = "Sum"
          region = var.region
        }
      },
      {
        type = "metric"
        x = 12
        y = 0
        width = 12
        height = 6
        properties = {
          title = "Console Login Failures"
          metrics = [
            [ var.project_name, "ConsoleLoginFailureCount" ]
          ]
          period = 300
          stat = "Sum"
          region = var.region
        }
      },
      {
        type = "metric"
        x = 0
        y = 6
        width = 12
        height = 6
        properties = {
          title = "IAM Policy Changes"
          metrics = [
            [ var.project_name, "IamPolicyChangesCount" ]
          ]
          period = 300
          stat = "Sum"
          region = var.region
        }
      },
      {
        type = "metric"
        x = 12
        y = 6
        width = 12
        height = 6
        properties = {
          title = "Access Keys Created"
          metrics = [
            [ var.project_name, "AccessKeyCreatedCount" ]
          ]
          period = 300
          stat = "Sum"
          region = var.region
        }
      },
      {
        type = "metric"
        x = 0
        y = 12
        width = 12
        height = 6
        properties = {
          title = "Security Group Open to World"
          metrics = [
            [ var.project_name, "SecurityGroupOpenWorldCount" ]
          ]
          period = 300
          stat = "Sum"
          region = var.region
        }
      },
      {
        type = "metric"
        x = 12
        y = 12
        width = 12
        height = 6
        properties = {
          title = "CloudTrail / Config Changes"
          metrics = [
            [ var.project_name, "CloudTrailChangesCount" ],
            [ var.project_name, "ConfigChangesCount" ]
          ]
          period = 300
          stat = "Sum"
          region = var.region
        }
      }
    ]
  })
}
