resource "aws_s3_bucket" "front" {
  bucket = "front-eql-xchange"
 acl = "public-read"
  
  website {
    index_document = "index.html"
    error_document = "index.html"

    force_destroy = true
  }
  
}



