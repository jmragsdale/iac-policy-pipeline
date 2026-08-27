# FIXTURE: intentionally non-compliant. The policy gate must reject this file.
# Do not copy this into real infrastructure.

resource "aws_s3_bucket" "public" {
  bucket = "jr-policy-demo-public"
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket                  = aws_s3_bucket.public.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "public" {
  bucket = aws_s3_bucket.public.id
  acl    = "public-read"
}
