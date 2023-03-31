# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.logGroup
  retention_in_days = 7

  tags = merge({
    Name = "${var.app_name}-${var.stage}-log-group"
  }, var.tags)
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.app_name}-${var.stage}-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}
