resource "aws_s3_bucket" "prod_websiteeql" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "frontAngular"
    Environment = "prod"
  }
  

  
}

resource "aws_s3_bucket_policy" "prod_websiteeql" {
  bucket = aws_s3_bucket.prod_websiteeql.id

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
                "arn:aws:s3:::${aws_s3_bucket.prod_websiteeql.id}/*"
            ]
        }
    ]
}
POLICY
}

