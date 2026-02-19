resource "aws_codedeploy_app" "this" {
  name             = "${var.function_name}-app"
  compute_platform = "Lambda"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = "${var.function_name}-dg"
  service_role_arn      = var.codedeploy_role_arn

  deployment_config_name = var.deployment_config

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  alarm_configuration {
    alarms  = var.alarm_names
    enabled = true
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
