list "aws_s3_buckket" "prod" {
  provider = aws 
  limit = 10
  config = {
    region = us-east-1
  } 
}