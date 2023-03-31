resource "aws_s3_bucket" "newput-logs" {
  count  = var.enable_lb_logs ? 1 : 0
  bucket = "${var.app_name}-${var.stage}"

  tags = var.tags
}

resource "aws_s3_bucket_policy" "newput-logs" {
  count  = var.enable_lb_logs ? 1 : 0
  bucket = aws_s3_bucket.newput-logs[0].id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Terraform-AccessLogs-Policy",
  "Statement": [
      {
          "Sid": "AWSConsoleStmt-1601501139556",
          "Effect": "Allow",
          "Principal": {
              "AWS": "arn:aws:iam::1111:root"
          },
          "Action": "s3:PutObject",
          "Resource": "arn:aws:s3:::${var.app_name}-${var.stage}/${var.lb_logs_bucket_prefix}/AWSLogs/*"
      },
      {
          "Sid": "AWSLogDeliveryWrite",
          "Effect": "Allow",
          "Principal": {
              "Service": "delivery.logs.amazonaws.com"
          },
          "Action": "s3:PutObject",
          "Resource": "arn:aws:s3:::${var.app_name}-${var.stage}/${var.lb_logs_bucket_prefix}/AWSLogs/*",
          "Condition": {
              "StringEquals": {
                  "s3:x-amz-acl": "bucket-owner-full-control"
              }
          }
      },
      {
          "Sid": "AWSLogDeliveryAclCheck",
          "Effect": "Allow",
          "Principal": {
              "Service": "delivery.logs.amazonaws.com"
          },
          "Action": "s3:GetBucketAcl",
          "Resource": "arn:aws:s3:::${var.app_name}-${var.stage}"
      }
  ]
}
POLICY
}
