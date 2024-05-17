variable "ami" {
	type        = string
	description = "Ami_id of instance"
	default     = "ami-0a7187996cbd8989f"
}

variable "instance_type" {
	type        = string
	description = "Type of EC2 instance(CPU,RAM,Disk,Network components)"
	default     = "t3.micro" 
}
