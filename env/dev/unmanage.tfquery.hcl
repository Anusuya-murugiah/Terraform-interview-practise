list "aws_s3_bucket" "prod" {
  provider = aws 
  limit = 10
  config {
    region = "us-east-1"
  } 
}