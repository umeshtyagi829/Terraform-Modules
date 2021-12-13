variable "subnets_ids" {
  type        = list(string)
  description = "subnet ids in which instances are to be launched."
}
variable "instance_type" {
  description = "Intance type to run"
  type        = string
}
variable "key_name" {
  description = "key for the instance to SSH"
  type        = string
}

variable "user_data" {
  type        = string
  description = "user-data for ec2."
  default     = ""
}

variable "tags" {
  type = map(any)
  default = {
    "ManagedBy" = "Terraform"
    "Cloud"     = "AWS"
  }

}

variable "associate_public_ip_address" {
  description = "Assign public IP address to instances"
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "Number of instance to launch."
  type        = number
  default     = 1
}

variable "ami_id" {
  type        = string
  description = "AMI id for the instance."
}

variable "security_group_name" {
  type        = string
  description = "Name of security group for EC2 istance."
  default     = "security-group-tf"
}

variable "sg_description" {
  default = "security group for instance"
  type    = string
}
variable "vpc_id" {
  type        = string
  description = "VPC id of security group"
}

variable "instance_ssh_cidr" {
  type = list(string)
}

variable "instance_ingress_ports" {
  description = "ingress ports"
  type        = list(string)
  default     = []
}