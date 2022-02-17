resource "aws_s3_bucket" "terradeploy" {
  bucket = "terradeploy"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.terradeploy.id
  acl    = "private"
}