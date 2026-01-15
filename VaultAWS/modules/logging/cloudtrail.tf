resource "aws_cloudtrail" "trail" {
  name                          = "${var.project_name}-trail"
  s3_bucket_name                = aws_s3_bucket.logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cw_role.arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  depends_on = [aws_s3_bucket_policy.logs]

  tags = {
    Project = var.project_name
  }
}
