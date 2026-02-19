variable "function_name" {}
variable "codedeploy_role_arn" {}
variable "deployment_config" {}
variable "alarm_names" {
  type = list(string)
}
variable "alias_name" {}