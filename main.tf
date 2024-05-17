module "my-vpc" {
	source = "./modules"
}

resource "aws_instance" "public" {
	ami                         = var.ami
	instance_type               = var.instance_type
	associate_public_ip_address = true
  subnet_id   = module.my-vpc.pub_sub_id
  vpc_security_group_ids      = [module.my-vpc.security_group_id]
  tags                        = var.pub_ec2_tag
}

resource "aws_instance" "private" {
	ami                    = var.ami
	instance_type          = var.instance_type
	subnet_id              = module.my-vpc.priv_sub_id
	vpc_security_group_ids = [module.my-vpc.security_group_id]
	tags                   = var.priv_ec2_tag
}
