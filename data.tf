data "aws_ecs_cluster" "this" {
  cluster_name = var.cluster_name
}

data "template_file" "env" {
  template = file("${path.module}/templates/env.json.tmpl")
  count    = length(var.env_vars)
  vars = {
    name  = element(keys(var.env_vars), count.index)
    value = element(values(var.env_vars), count.index)
  }
}

data "template_file" "secrets" {
  template = file("${path.module}/templates/secret.json.tmpl")
  count    = length(var.secret_arns)
  vars = {
    name = element(keys(var.secret_arns), count.index)
    arn  = element(values(var.secret_arns), count.index)
  }
}






/*
data "template_file" "datadog_env" {
  template = file("./templates/env.json.tmpl")
  count    = length(var.datadog_env_config)
  vars = {
    name  = element(keys(var.datadog_env_config), count.index)
    value = element(values(var.datadog_env_config), count.index)
  }
}

data "template_file" "datadog_secrets" {
  template = file("./templates/secret.json.tmpl")
  count    = length(var.datadog_secret_arns)
  vars = {
    name = element(keys(var.datadog_secret_arns), count.index)
    arn  = element(values(var.datadog_secret_arns), count.index)
  }
}
*/