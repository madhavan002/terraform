variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "lambda_bucket" {
  description = "The AWS S3 bucket which contains the Lambda Code as jar."
  default     = "css-terraform-lambda"
}

variable "lambda_bucket_key" {
  description = "The AWS S3 bucket key which points to path for Lambda Code as jar. This path would support versioning if needed."
  default     = "v1.0.0/css-lambda.jar"
}

variable "lambda_handler" {
  description = "Lambda function handler"
  default     = "com.css.demolambda.AMIInstanceHandler::handleRequest"
}

variable "lambda_runtime" {
  description = "Java Runtime"
  default     = "java8"
}

variable "lambda_memorysize" {
  description = "Default Memory in MB"
  default     = "512"
}

variable "lambda_timeout" {
  description = "Default Timeout in secs"
  default     = "15"
}

