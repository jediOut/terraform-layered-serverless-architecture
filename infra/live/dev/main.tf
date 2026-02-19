
module "database" {
  source  = "../../modules/database"
  db_name = "dev-bd"
}

resource "aws_iam_role" "codedeploy_role" {
  name = "api-dev-codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForLambda"
}
resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "lambda-error-api-dev"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    FunctionName = module.api_lambda.lambda_name
  }
}
module "api_lambda" {
  source = "../../modules/lambda"

  function_name = "api-dev"
  lambda_zip    = "../../../backend/api/dist.zip"

  table_name = module.database.table_name
}

module "codedeploy" {
  source = "../../modules/codedeploy"

  function_name = module.api_lambda.lambda_name
  alias_name    = module.api_lambda.alias_name

  codedeploy_role_arn = aws_iam_role.codedeploy_role.arn
  deployment_config   = "CodeDeployDefault.LambdaCanary10Percent5Minutes"
  alarm_names         = [aws_cloudwatch_metric_alarm.lambda_errors.alarm_name]
}



