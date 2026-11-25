module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  
  name = "single-instance"
  
  instance_type = var.instance_type
  key_name = "us-openclaw"
  monitoring = true
  ami = var.ami_id
  
  tags = merge (
    {Terraform = "true"}, 
    var.tags 
    )
}
