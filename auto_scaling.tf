resource "aws_appautoscaling_target" "target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "up" {
  name               = "${var.app_name}_${var.stage}_scale_up"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = var.up_adjustment_type
    cooldown                = var.up_cooldown
    metric_aggregation_type = var.up_metric_aggregation_type

    step_adjustment {
      metric_interval_lower_bound = var.up_metric_interval_lower_bound
      metric_interval_upper_bound = var.up_metric_interval_upper_bound
      scaling_adjustment          = var.up_scaling_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

# Automatically scale capacity up by one if memory is above threshold
resource "aws_appautoscaling_policy" "mem_up" {
  name               = "${var.app_name}_${var.stage}_scale_mem_up"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = var.up_adjustment_type
    cooldown                = var.up_cooldown
    metric_aggregation_type = var.up_metric_aggregation_type

    step_adjustment {
      metric_interval_lower_bound = var.up_metric_interval_lower_bound
      metric_interval_upper_bound = var.up_metric_interval_upper_bound
      scaling_adjustment          = var.up_scaling_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "down" {
  name               = "${var.app_name}_${var.stage}_scale_down"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = var.down_adjustment_type
    cooldown                = var.down_cooldown
    metric_aggregation_type = var.down_metric_aggregation_type

    step_adjustment {
      metric_interval_lower_bound = var.down_metric_interval_lower_bound
      metric_interval_upper_bound = var.down_metric_interval_upper_bound
      scaling_adjustment          = var.down_scaling_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

# Automatically scale capacity down by one if memory is below threshold
resource "aws_appautoscaling_policy" "mem_down" {
  name               = "${var.app_name}_${var.stage}_scale_mem_down"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = var.down_adjustment_type
    cooldown                = var.down_cooldown
    metric_aggregation_type = var.down_metric_aggregation_type

    step_adjustment {
      metric_interval_lower_bound = var.down_metric_interval_lower_bound
      metric_interval_upper_bound = var.down_metric_interval_upper_bound
      scaling_adjustment          = var.down_scaling_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}
