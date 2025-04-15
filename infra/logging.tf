resource "aws_cloudtrail" "main" {
  name                          = "main-trail"
  s3_bucket_name                = aws_s3_bucket.trail_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.trail_log_group.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
}

resource "aws_s3_bucket" "trail_bucket" {
  bucket = "your-unique-trail-logs-bucket"
}

resource "aws_cloudwatch_log_group" "trail_log_group" {
  name = "/aws/cloudtrail/logs"
}

resource "aws_iam_role" "cloudtrail_role" {
  name = "cloudtrail-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "cloudtrail_policy" {
  name = "cloudtrail-logs-policy"
  role = aws_iam_role.cloudtrail_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "logs:PutLogEvents",
        "logs:CreateLogStream"
      ],
      Resource = "${aws_cloudwatch_log_group.trail_log_group.arn}:*"
    }]
  })
}
