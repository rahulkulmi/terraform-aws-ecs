resource "aws_lb" "this" {
  name            = trimsuffix(substr("${var.app_name}-${var.stage}", 0, 32), "-")
  subnets         = var.loadbalancer_internal ? var.private_subnet_ids : var.public_subnet_ids
  security_groups = concat(var.loadbalancer_additional_security_groups, aws_security_group.lb.*.id) # aws_security_group.lb.id
  internal        = var.loadbalancer_internal
  idle_timeout    = var.lb_idle_timeout
  # load_balancer_type = "application"

  /*dynamic "access_logs" {
    for_each = var.enable_lb_logs ? [1] : []
    content {
      bucket  = aws_s3_bucket.tuvoli-logs[0].bucket
      prefix  = var.lb_logs_bucket_prefix
      enabled = true
    }
  }*/

  tags = var.tags
}

/*
resource "aws_security_group" "lb" {
  name        = "${var.app_name}-${var.stage}-lb-security-group"
  description = "Controls access to the LB"
  vpc_id      = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "ingress" {
  count = var.use_loadbalancer ? length(var.loadbalancer_ingress_rules) : 0

  type              = "ingress"
  security_group_id = aws_security_group.lb[0].id

  protocol    = var.loadbalancer_ingress_rules[count.index].protocol
  from_port   = var.loadbalancer_ingress_rules[count.index].from_port
  to_port     = var.loadbalancer_ingress_rules[count.index].to_port
  cidr_blocks = var.loadbalancer_ingress_rules[count.index].cidr_blocks
}

resource "aws_security_group_rule" "egress" {
  count = var.use_loadbalancer ? length(var.loadbalancer_egress_rules) : 0

  type              = "egress"
  security_group_id = aws_security_group.lb[0].id

  protocol    = var.loadbalancer_egress_rules[count.index].protocol
  from_port   = var.loadbalancer_egress_rules[count.index].from_port
  to_port     = var.loadbalancer_egress_rules[count.index].to_port
  cidr_blocks = var.loadbalancer_egress_rules[count.index].cidr_blocks
}
*/

resource "aws_lb_target_group" "this" {
  name        = trimsuffix(substr("${var.app_name}-${var.stage}-target-group", 0, 32), "-")
  port        = var.app_port
  protocol    = var.loadbalancer_target_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled = true
    path    = var.healthcheck_path
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn # aws_lb.this[0].id
  port              = var.loadbalancer_port # 443
  protocol          = var.loadbalancer_listener_protocol
  certificate_arn   = var.loadbalancer_use_cert ? var.loadbalancer_cert_arn : null # data.aws_acm_certificate.ssl_cert.arn
  ssl_policy        = var.loadbalancer_use_cert ? var.loadbalancer_ssl_policy : null

  default_action {
    target_group_arn = aws_lb_target_group.this.arn # aws_lb_target_group.this[0].id
    type             = "forward"
  }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.this.arn # aws_lb.this[0].id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# resource "aws_lb_listener_certificate" "example" {
#   listener_arn    = aws_lb_listener.this.arn
#   certificate_arn = data.aws_acm_certificate.ssl_cert.arn
# }
