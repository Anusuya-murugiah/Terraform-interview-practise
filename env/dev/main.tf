module "ec2" {
   source = "../../module/ec2"
   ami_id = var.ami_id
   instance_type = var.instance_type 
 }

import {
  to = aws_s3_bucket.demo
  id = "ecommerce-frontend-oct"
}

resource "aws_s3_bucket" demo {
  bucket = ecommerce-frontend-oct
}