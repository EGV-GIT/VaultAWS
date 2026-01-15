data "aws_iam_policy_document" "guardrails" {

  statement {
    sid    = "DenyDisableCloudTrail"
    effect = "Deny"
    actions = [
      "cloudtrail:StopLogging",
      "cloudtrail:DeleteTrail"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyDisableConfig"
    effect = "Deny"
    actions = [
      "config:StopConfigurationRecorder",
      "config:DeleteConfigurationRecorder",
      "config:DeleteDeliveryChannel"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyLogBucketDeletion"
    effect = "Deny"
    actions = [
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:PutBucketAcl",
      "s3:PutBucketPolicy"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyOutsideSydney"
    effect = "Deny"
    actions = ["*"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values   = ["ap-southeast-2"]
    }
  }
}

resource "aws_iam_policy" "guardrails" {
  name   = "${var.project_name}-Guardrails"
  policy = data.aws_iam_policy_document.guardrails.json
}

resource "aws_iam_role_policy_attachment" "guardrails_attach" {
  role       = aws_iam_role.terraform_deploy.name
  policy_arn = aws_iam_policy.guardrails.arn
}
