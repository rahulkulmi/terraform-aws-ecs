locals {
  logGroup     = "/ecs/${var.app_name}/${var.stage}"
  templatePath = "${path.module}/templates/ecs_app.json.tmpl"
  # templatePath = var.use_default_ecs_template ? "${path.module}/templates/ecs.json.tmpl" : var.template_file_path
  template_vars = merge({
    image          = "${var.image_name}:${var.image_tag}"
    app_name       = var.app_name
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    region         = var.region
    logGroup       = local.logGroup
    # use_datadog         = var.use_datadog
    # use_datadog_logging = var.use_datadog_logging
    # datadog_api_key     = var.datadog_api_key
    }, {
    env_config    = join(",", data.template_file.env.*.rendered)
    secret_config = join(",", data.template_file.secrets.*.rendered)
    # datadog_env_config    = join(",", data.template_file.datadog_env.*.rendered)
    # datadog_secret_config = join(",", data.template_file.datadog_secrets.*.rendered)
  })
}
