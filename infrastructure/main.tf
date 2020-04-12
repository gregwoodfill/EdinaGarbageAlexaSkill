provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "gjw-terraform-state-s3"
    region         = "us-east-2"
    key            = "tf/state/edina-garbage.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

resource "aws_lambda_function" "default" {
  filename         = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")
  function_name    = "edina_garbage_alexa_skill"
  role             = aws_iam_role.default.arn
  handler          = "edina_garbage.handler.lambda_handler"
  runtime          = "python3.8"
}

resource "aws_lambda_permission" "default" {
  statement_id  = "AllowExecutionFromAlexa"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.function_name
  principal     = "alexa-appkit.amazon.com"
}

resource "aws_iam_role" "default" {
  name = "terraform_lambda_alexa_example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

####
# Alternatively you could attach the Amazon provided AWSLambdaBasicExecutionRole
# via an aws_iam_policy_attachment resource. However, the aws_iam_policy_attachment
# resource can be [destructive](https://www.terraform.io/docs/providers/aws/r/iam_policy_attachment.html)
# so it was avoided for the purporse of this example.
resource "aws_iam_role_policy" "default" {
  name = "terraform_lambda_alexa_example"
  role = aws_iam_role.default.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
