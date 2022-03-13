provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "udacity_hungnv127_role_for_lambda" {
    name   = "udacity_hungnv127_role_for_lambda"
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

resource "aws_iam_policy" "udacity_hungnv127_iam_policy_for_lambda" {
    name         = "udacity_hungnv127_iam_policy_for_lambda"
    path         = "/"
    policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "udacity_hungnv127_attach_iam_policy_to_iam_role" {
    role        = aws_iam_role.udacity_hungnv127_role_for_lambda.name
    policy_arn  = aws_iam_policy.udacity_hungnv127_iam_policy_for_lambda.arn
}
 
data "archive_file" "zip_python_file" {
    type        = "zip"
    source_file = "greet_lambda.py"
    output_path = "greet_lambda.zip"
}
    
resource "aws_lambda_function" "udacity_hungnv127_terrform_lambda" {
    filename                       = "greet_lambda.zip"
    function_name                  = "greet_lambda"
    role                           = aws_iam_role.udacity_hungnv127_role_for_lambda.arn
    handler                        = "greet_lambda.lambda_handler"
    runtime                        = "python3.7"
    depends_on                     = [aws_iam_role_policy_attachment.udacity_hungnv127_attach_iam_policy_to_iam_role]
    environment {
        variables = {
            greeting = "Greet"
        }
    }
}