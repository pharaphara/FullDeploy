resource "aws_s3_bucket" "terradeploybucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My deploy bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terradeploybucket.id
  acl    = "private"
}