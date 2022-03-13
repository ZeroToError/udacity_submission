# TODO: Define the output variable for the lambda function.
output "lambda" {
  value = "${aws_lambda_function.udacity_hungnv127_terrform_lambda.qualified_arn}"
}