# FIXTURE: compliant. The policy gate must accept this file.

resource "aws_s3_bucket" "secure" {
  bucket = "jr-policy-demo-secure"
}

resource "aws_s3_bucket_public_access_block" "secure" {
  bucket                  = aws_s3_bucket.secure.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "secure" {
  bucket = aws_s3_bucket.secure.id
  acl    = "private"
}
