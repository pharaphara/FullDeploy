resource "aws_s3_bucket" "terradeploybucketeql" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My deploy bucket eql"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terradeploybucketeql.id
  acl    = "private"
}