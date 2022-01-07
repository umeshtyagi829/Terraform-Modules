#-------------------
# VARIABLES FOR VPC|
#-------------------
variable "vpc_cidr" {
  type = string
  description = "A CIDR block range for VPC."
}

variable "azs" {
  description = "A list of availability zones"
  type        = list(string)

}

variable "private_subnet_cidr" {
  description = "A list private subnets cidr"
  type        = list(any)
}

variable "public_subnet_cidr" {
  description = "A list public subnets cidr"
  type        = list(any)
}

variable "tag_prefix" {
  type        = string
  description = "Value for tag prefix. This value adds in each resources name tag."

}

#-------------------------
# VARIABLES FOR INSTACNES|
#-------------------------
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Assign instance type"
}

variable "key_name" {
  type        = string
  description = "Assign key name. It helps to SSH to the instances"
}

# alb security group ingress port
variable "ingress_ports" {
  type = list(string)
  description = "A list of ports. It uses by security group for traffic"
}

variable "max_size" {
  type = string
  description = "asg maximum number of instances limit"

}

variable "min_size" {
  type = string
  description = "ASG manimum number of instances limit"
}
variable "desire_size" {
  type = string
  description = "ASG number of instances limit which will be running"
}
variable "launch_config_name" {
  type = string
  description = "choose launch configuration name"
}
variable "health_check_grace_period" {
  type = string
  description = "choose health_check_grace_period value"
}
#-------------------
# VARIABLES FOR ALB|
#-------------------
variable "alb_name" {
  description = "application load balancer name"
  type        = string
}

variable "load_balancer_type" {
  type        = string
  description = "choose load_balancer_type"
}

variable "internal" {
  type = bool
}

variable "enable_deletion_protection" {
  type = bool
}

variable "target_group_name" {
  description = "application load balancer target group name"
  type        = string
}

variable "target_group_port" {
  type = string
}

variable "target_group_protocol" {
  type = string
}

variable "heath_check_path" {
  type = string
}

variable "heath_check_port" {
  type = string
}

variable "heath_check_healthy_threshold" {
  type = string
}

variable "heath_check_unhealthy_threshold" {
  type = string
}

variable "heath_check_timeout" {
  type = string
}
variable "heath_check_interval" {
  type = string
}
variable "heath_check_matcher" {
  type = string
}

#-------------------
# VARIABLES FOR RDS|
#-------------------
variable "rds_instance_name" {
  description = "rds instance name"
  type        = string
}

variable "subnet_group_name" {
  description = "database subnet group name"
  type        = string
}

variable "security_group_name" {
  description = "database security group name"
  type        = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "protocol" {
  type = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}
variable "db_username" {
  description = "Database username"
  type        = string
}
variable "db_password" {
  description = "Database password"
  type        = string
}

variable "multi_az" {
  type        = bool
  description = "multi_az"
}

variable "db_instance_class" {
  type = string
}
# aws credentials
variable "region" {
  type = string
}