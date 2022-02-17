resource "aws_s3_bucket" "front" {
  bucket = "front-eql-xchange"

  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}
resource "aws_s3_bucket_acl" "public" {
  bucket = aws_s3_bucket.front.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "front" {
  bucket = aws_s3_bucket.front.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                 "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.front.id}/*"
            ]
        }
    ]
}
POLICY
}

