module "my-vpc" {
	source = "./modules"
}

resource "aws_instance" "public" {
	ami                         = var.ami
	instance_type               = var.instance_type
	associate_public_ip_address = true
	subnet_id   = module.my-vpc.public_subnet_id
	vpc_security_group_ids      = [module.my-vpc.security_group_id]
}
