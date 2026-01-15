resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/${var.project_name}"
  retention_in_days = 30

  tags = {
    Project = var.project_name
  }
}

data "aws_iam_policy_document" "cloudtrail_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cloudtrail_cw_role" {
  name               = "${var.project_name}-CloudTrailToCloudWatch"
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_assume_role.json
}

data "aws_iam_policy_document" "cloudtrail_cw_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.cloudtrail.arn}:*"]
  }
}

resource "aws_iam_role_policy" "cloudtrail_cw_role_policy" {
  name   = "${var.project_name}-CloudTrailToCloudWatchPolicy"
  role   = aws_iam_role.cloudtrail_cw_role.id
  policy = data.aws_iam_policy_document.cloudtrail_cw_policy.json
}
