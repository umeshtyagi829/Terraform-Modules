#-----------------
# Security Group |
#-----------------
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

variable "alb_sg_id" {
  type = list(string)
}

#------------------
# Launch Template |
#------------------
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

variable "ami_id" {
  type        = string
  description = "AMI id for the instance."
}

variable "launch_config_name" {
  type    = string
  default = "aws-cf"
}

variable "volume_size" {
  type    = number
  default = 10
}

#---------------------
# Auto Scaling Group |
#---------------------
variable "target_group_arn" {
  description = "target group arn"
  type        = list(string)
}

variable "autoscaling_group_name" {
  type        = string
  default     = "aws-asg"
  description = "Auto Scaling Group Name"
}

variable "max_size" {
  type = string
}

variable "min_size" {
  type = string
}

variable "desire_size" {
  type = string
}

variable "health_check_type" {
  type    = string
  default = "EC2"
}

variable "health_check_grace_period" {
  type = string
  description = "health_check_grace_period value"
  default = "300"
}
variable "subnets_ids" {
  type        = list(string)
  description = "subnet ids in which instances are to be launched."
}

variable "tag_prefix" {
  type        = string
  default     = ""
  description = "tag prefix"

}

variable "default_tags" {
    description = "Default Tags for Auto Scaling Group"
    type        = map(string)
    default     = {}
}