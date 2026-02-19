resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = "lambda.handler"
  runtime       = "nodejs18.x"


  role     = aws_iam_role.lambda_role.arn
  filename = var.lambda_zip

  environment {
    variables = {
      DB_TABLE_NAME = var.table_name
    }
  }
}

resource "aws_lambda_alias" "live" {
  name             = "live"
  function_name    = aws_lambda_function.this.function_name
  function_version = "$LATEST"
}
