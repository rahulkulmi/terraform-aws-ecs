resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}-${var.stage}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = templatefile(local.templatePath, local.template_vars) # data.template_file.app.rendered
  tags                     = var.tags
}

resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-${var.stage}-service"
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
  cluster         = data.aws_ecs_cluster.this.id

  network_configuration {
    security_groups  = concat([aws_security_group.ecs_tasks.id], var.additional_task_security_group_ids)
    subnets          = var.private_subnet_ids # aws_subnet.private.*.id
    assign_public_ip = false
  }

  dynamic "load_balancer" {
    for_each = concat(aws_lb_target_group.this.*.id, var.additional_target_group_arns)

    content {
      target_group_arn = load_balancer.value
      container_name   = var.app_name
      container_port   = var.app_port
    }
  }

  tags = merge({
    Name = "${var.app_name}-${var.stage}-log-group"
  }, var.tags)

  depends_on = [aws_lb_listener.this, aws_lb_listener.redirect_http_to_https, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
