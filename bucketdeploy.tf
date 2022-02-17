resource "aws_s3_bucket" "terradeploy" {
  bucket = "terradeploy"

}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terradeploy.id
  acl    = "private"
}