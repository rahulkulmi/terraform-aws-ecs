resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = "${var.app_name}_${var.stage}_cpu_utilization_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.high_cpu_alarm_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.high_cpu_alarm_period
  statistic           = "Average"
  threshold           = var.high_cpu_alarm_threshold

  dimensions = {
    ClusterName = var.cluster_name # aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name # aws_ecs_service.this.name
  }

  # alarm_actions = [aws_appautoscaling_policy.up.arn]
  alarm_actions = var.high_cpu_alarm_actions
}

/* no needed alarm for this
# CloudWatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.app_name}_${var.stage}_cpu_utilization_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = var.cluster_name # aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name # aws_ecs_service.this.name
  }

  # alarm_actions = [aws_appautoscaling_policy.down.arn]
  alarm_actions = var.low_cpu_alarm_actions
}
*/

# CloudWatch alarm that triggers the autoscaling high memory
resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "${var.app_name}_${var.stage}_memory_utilization_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.high_memory_alarm_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.high_memory_alarm_period
  statistic           = "Average"
  threshold           = var.high_memory_alarm_threshold

  dimensions = {
    ClusterName = var.cluster_name # aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name # aws_ecs_service.this.name
  }

  # alarm_actions = [aws_appautoscaling_policy.mem_up.arn]
  alarm_actions = var.high_memory_alarm_actions
}

/*
resource "aws_cloudwatch_metric_alarm" "low_memory" {
  alarm_name          = "${var.app_name}_${var.stage}_memory_utilization_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.low_memory_alarm_low_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.low_memory_alarm_low_period
  statistic           = "Average"
  threshold           = var.low_memory_alarm_low_threshold

  dimensions = {
    ClusterName = var.cluster_name # aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name # aws_ecs_service.this.name
  }

  alarm_actions = var.low_memory_alarm_actions
}
*/

resource "aws_cloudwatch_metric_alarm" "no_running_tasks" {
  alarm_name          = "${var.app_name}_${var.stage}_no_running_tasks"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "RunningTaskCount"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.main.name # aws_ecs_service.this.name
  }

  alarm_actions = var.no_running_tasks_alarm_actions
}

/*
resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = "${var.app_name}_${var.stage}_autoscale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.autoscaling_alarm_high_evaluation_periods
  metric_name         = var.autoscaling_alarm_high_metric_name
  namespace           = "AWS/ECS"
  period              = var.autoscaling_alarm_high_period
  statistic           = "Average"
  threshold           = var.autoscaling_alarm_high_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [module.autoscaling.autoscaling_policy_up_arn]
}

resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.app_name}_${var.stage}_autoscale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.autoscaling_alarm_low_evaluation_periods
  metric_name         = var.autoscaling_alarm_low_metric_name
  namespace           = "AWS/ECS"
  period              = var.autoscaling_alarm_low_period
  statistic           = "Average"
  threshold           = var.autoscaling_alarm_low_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [module.autoscaling.autoscaling_policy_down_arn]
}

resource "aws_cloudwatch_metric_alarm" "service_memory_high" {
  alarm_name          = "${var.app_name}_${var.stage}_autoscale_memory_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.autoscaling_alarm_high_evaluation_periods
  metric_name         = var.autoscaling_alarm_high_memory_metric_name
  namespace           = "AWS/ECS"
  period              = var.autoscaling_alarm_high_period
  statistic           = "Average"
  threshold           = var.autoscaling_alarm_high_memory_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [module.autoscaling.autoscaling_policy_mem_up_arn]
}

resource "aws_cloudwatch_metric_alarm" "service_memory_low" {
  alarm_name          = "${var.app_name}_${var.stage}_autoscale_memory_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.autoscaling_alarm_low_evaluation_periods
  metric_name         = var.autoscaling_alarm_high_memory_metric_name
  namespace           = "AWS/ECS"
  period              = var.autoscaling_alarm_low_period
  statistic           = "Average"
  threshold           = var.autoscaling_alarm_low_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [module.autoscaling.autoscaling_policy_mem_down_arn]
}
*/
