variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region to deploy resources"
}

# variable "access_key" {
#   description = "My AWS access key"
# }

# variable "secret_key" {
#   description = "My AWS secret key"
# }

variable "stage" {
  default = "dev"
}

variable "app_name" {
  type        = string
  description = "The application name"
}

variable "image_name" {
  description = "Image for ECS Task"
}

variable "image_tag" {
  description = "Image for ECS Task"
  default     = "latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

# variable "template_file_path" {
#   type        = string
#   default     = null
#   description = "The relative path to the ECS template file"
# }

variable "cluster_name" {
  type        = string
  description = "The cluster to add the ECS service to"
}

# variable "service_name" {
#   type        = string
#   description = "The cluster to add the ECS service to"
#   default     = aws_ecs_service.main.name
# }

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "healthcheck_path" {
  type        = string
  description = "Path of load balancer health check"
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "Id of the vpc to install into"
}

variable "public_subnet_ids" {
  type        = list(string)
  default     = []
  description = "List of public subnet ids"
}

variable "private_subnet_ids" {
  type        = list(string)
  default     = []
  description = "List of private subnet ids"
}

# variable "enable_loadbalancer_redirect_http_to_https_listener" {
#   default = false
# }

variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone to contain this record."
}

variable "record_name" {
  type        = string
  description = "Name of the Route 53 record"
}

variable "ttl" {
  type        = number
  default     = 30
  description = "TTL of the record set"
}

# variable "use_default_ecs_template" {
#   type        = bool
#   default     = true
#   description = "Use the default ecs template provided with this template"
# }

variable "additional_task_security_group_ids" {
  description = "Additional security groups to assigne to the ECS task."
  default     = []
}

variable "additional_target_group_arns" {
  default     = []
  description = "Additional load balancer target groups to add"
}

variable "env_vars" {
  type        = map(string)
  default     = {}
  description = "Map of environment vars to make is easier to pass"
}

variable "secret_arns" {
  type        = map(string)
  default     = {}
  description = "Map of secrets to use in the template"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}

## Cloudwatch Alarms vars
variable "create_cpu_alarms" {
  default = false
}

variable "create_memory_alarms" {
  default = false
}

variable "create_no_running_task_alarm" {
  default = false
}

variable "high_cpu_alarm_evaluation_periods" {
  default = "2"
}

variable "high_cpu_alarm_period" {
  default = "60"
}

variable "high_cpu_alarm_threshold" {
  default = "80"
}

variable "high_memory_alarm_evaluation_periods" {
  default = "2"
}

variable "high_memory_alarm_period" {
  default = "60"
}

variable "high_memory_alarm_threshold" {
  default = "80"
}

variable "high_cpu_alarm_actions" {
  type        = list(string)
  default     = []
  description = "High CPU alarm actions"
}

variable "high_memory_alarm_actions" {
  type        = list(string)
  default     = []
  description = "High Memory alarm actions"
}

variable "no_running_tasks_alarm_actions" {
  type        = list(string)
  default     = []
  description = "No running tasks alarm actions"
}

variable "autoscaling_alarm_high_evaluation_periods" {
  default = "2"
}

variable "autoscaling_alarm_high_period" {
  default = "60"
}

variable "autoscaling_alarm_high_threshold" {
  default = "80"
}

variable "autoscaling_alarm_high_metric_name" {
  default = "CPUUtilization"
}

variable "autoscaling_alarm_low_evaluation_periods" {
  default = "2"
}

variable "autoscaling_alarm_low_period" {
  default = "60"
}

variable "autoscaling_alarm_low_threshold" {
  default = "20"
}

variable "autoscaling_alarm_low_metric_name" {
  default = "CPUUtilization"
}

variable "autoscaling_alarm_high_memory_metric_name" {
  default = "MemoryUtilization"
}

variable "autoscaling_alarm_high_memory_threshold" {
  default = "80"
}
## End Cloudwatch Alarms vars

# LB vars
variable "use_loadbalancer" {
  default = true
}

variable "loadbalancer_internal" {
  default     = false
  description = "Whether the load balancer is internal or not."
}

# variable "loadbalancer_ingress_rules" {
#   type        = list(object({ protocol = string, from_port = number, to_port = number, cidr_blocks = list(string) }))
#   description = "List of ingress rules for load balancer"
#   default     = []
# }

# variable "loadbalancer_egress_rules" {
#   type        = list(object({ protocol = string, from_port = number, to_port = number, cidr_blocks = list(string) }))
#   description = "List of egress rules for load balancer"
#   default     = []
# }

variable "loadbalancer_additional_security_groups" {
  type        = list(string)
  default     = []
  description = "List of security groups to add to the load balancer"
}

variable "loadbalancer_port" {
  type        = number
  default     = 80
  description = "The port for the load balancer listener"
}

variable "loadbalancer_listener_protocol" {
  type        = string
  default     = "HTTPS"
  description = "The protocol for the load balancer listener"
}

variable "loadbalancer_target_protocol" {
  type        = string
  default     = "HTTP"
  description = "The protocol for the load balancer target group"
}

variable "loadbalancer_use_cert" {
  type        = bool
  default     = true
  description = "Whether to use an ssl cert on the load balancer listener"
}

variable "loadbalancer_cert_arn" {
  type        = string
  default     = null
  description = "The ARN of the cert to use for the load balancer listener"
}

variable "loadbalancer_ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  description = "The Security Policy to use for the load balancer listener"
}

variable "lb_idle_timeout" {
  default = 60
}

variable "enable_lb_logs" {
  type    = bool
  default = false
}

variable "lb_logs_bucket_prefix" {
  default = "lb-logs"
}
# End LB vars

## Autoscaling vars
variable "min_capacity" {
  type        = number
  default     = 1
  description = "The minimum number of instances to run"
}

variable "max_capacity" {
  type        = number
  default     = 2
  description = "The maximum number of instances to run"
}

variable "up_adjustment_type" {
  type        = string
  description = "The adjustment type for the up autoscaling policy"
  default     = "ChangeInCapacity"
}

variable "up_cooldown" {
  type        = number
  description = "The cooldown for the up autoscaling policy"
  default     = 60
}

variable "up_metric_aggregation_type" {
  type        = string
  default     = "Average"
  description = "The aggregation type for the up policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'. Without a value, AWS will treat the aggregation type as 'Average'."
}

variable "up_metric_interval_lower_bound" {
  type        = number
  description = "The lower bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as negative infinity."
  default     = 1.0
}

variable "up_metric_interval_upper_bound" {
  type        = number
  description = "The upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound."
  default     = null
}

variable "up_scaling_adjustment" {
  type        = string
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down."
  default     = 1
}

variable "down_adjustment_type" {
  type        = string
  description = "The adjustment type for the down autoscaling policy"
  default     = "ChangeInCapacity"
}

variable "down_cooldown" {
  type        = number
  description = "The cooldown for the down autoscaling policy"
  default     = 60
}

variable "down_metric_aggregation_type" {
  type        = string
  default     = "Average"
  description = "The aggregation type for the down olicy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'. Without a value, AWS will treat the aggregation type as 'Average'."
}

variable "down_metric_interval_lower_bound" {
  type        = number
  description = "The lower bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as negative infinity."
  default     = null
}

variable "down_metric_interval_upper_bound" {
  type        = number
  description = "The upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound."
  default     = 0.0
}

variable "down_scaling_adjustment" {
  type        = string
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down."
  default     = -1
}
## End autoscaling vars


/*
## datadog vars
variable "use_datadog" {
  default = false
}

variable "use_datadog_logging" {
  default = false
}

variable "datadog_api_key" {
  default = null
}

variable "datadog_env_config" {
  type = map(string)
  default = {
    ECS_FARGATE = "true"
  }
  description = "Map of environment vars to make is easier to pass"
}

variable "datadog_secret_arns" {
  type        = map(string)
  default     = {}
  description = "Map of secrets to use in the template"
}
## End datadog vars
*/
