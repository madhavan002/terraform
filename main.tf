# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

#AssumeRole lambda service policy
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

 # IAM role which dictates what other AWS services the Lambda function
 # may access.
 resource "aws_iam_role" "lambda_exec" {
   name = "serverless_css_lambda"
   assume_role_policy = data.aws_iam_policy_document.policy.json
 }
 
 #Attach EC2 read only access policy for lambda to describe the EC2 instances
 resource "aws_iam_role_policy_attachment" "AmazonEC2ReadOnlyAccess" {
     role      = aws_iam_role.lambda_exec.name
     policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
 }
 
 #Lambda function resource with code retrieved from S3 bucket
 resource "aws_lambda_function" "getEC2Instances" {
   function_name = "getEC2Instances"
   s3_bucket = var.lambda_bucket
   s3_key    = var.lambda_bucket_key
   handler = var.lambda_handler
   runtime = var.lambda_runtime
   memory_size = var.lambda_memorysize
   timeout = var.lambda_timeout
   role = aws_iam_role.lambda_exec.arn
 }


 
 
 
