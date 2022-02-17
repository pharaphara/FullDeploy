resource "aws_s3_bucket" "terradeploy" {
  bucket = "terradeploy"
  force_destroy = true

}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terradeploy.id
  acl    = "private"
}