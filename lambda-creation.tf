data "archive_file" "welcome_python" {
  type        = "zip"
  source_file = "welcome.py"
  output_path = "outputs/welcome.zip"
}

resource "aws_lambda_function" "lambda_create" {
  filename      = "outputs/welcome.zip"
  function_name = "lambda_welcome"
  role          = aws_iam_role.lambda_role.arn
  handler       = "welcome.hello"
  source_code_hash = filebase64sha256("outputs/welcome.zip")

  runtime = "python3.7"
}