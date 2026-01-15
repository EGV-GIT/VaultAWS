resource "aws_cloudwatch_log_group" "vpc_flowlogs" {
  name              = "/${var.project_name}/vpc-flowlogs"
  retention_in_days = 30

  tags = {
    Project = var.project_name
  }
}

data "aws_iam_policy_document" "flowlogs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "flowlogs_role" {
  name               = "${var.project_name}-VPCFlowLogsRole"
  assume_role_policy = data.aws_iam_policy_document.flowlogs_assume_role.json
}

data "aws_iam_policy_document" "flowlogs_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["${aws_cloudwatch_log_group.vpc_flowlogs.arn}:*"]
  }
}

resource "aws_iam_role_policy" "flowlogs_role_policy" {
  name   = "${var.project_name}-VPCFlowLogsPolicy"
  role   = aws_iam_role.flowlogs_role.id
  policy = data.aws_iam_policy_document.flowlogs_policy.json
}

resource "aws_flow_log" "vpc" {
  vpc_id               = aws_vpc.main.id
  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flowlogs.arn
  iam_role_arn         = aws_iam_role.flowlogs_role.arn

  tags = {
    Name    = "${var.project_name}-VPCFlowLogs"
    Project = var.project_name
  }
}
