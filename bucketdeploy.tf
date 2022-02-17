resource "aws_s3_bucket" "deploybucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My deploy bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.deploybucket.id
  acl    = "private"
}