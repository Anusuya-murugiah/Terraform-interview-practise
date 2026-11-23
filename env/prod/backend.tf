terraform {
  backend "s3" {
    bucket =  "terraform-multienv-dev"
    key = "*"
    region = "us-east-1"
    use_lockfile = true      
  }
}
