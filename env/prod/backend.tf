terraform {
  backend "s3" {
    bucket =  "terraform-multienv-dev"
    key = "terraform-multienv-prod/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true      
  }
}
