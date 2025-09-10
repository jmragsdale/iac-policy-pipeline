package main
deny[msg] {
  input.resource_type == "aws_s3_bucket"
  input.public == true
  msg := sprintf("S3 bucket %s must not be public", [input.name])
}
