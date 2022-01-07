#-------------------
# VARIABLES FOR VPC|
#-------------------
variable "vpc_cidr" {
  description = "custom vpc"
}

variable "azs" {
  description = "availability zones for subnets"
  type        = list(string)

}

variable "private_subnet_cidr" {
  description = "private subnet cidr"
  type        = list(any)
}

variable "public_subnet_cidr" {
  description = "public subnet cidr"
  type        = list(any)
}

variable "tag_prefix" {
  type        = string
  description = "tag prefix"

}

#-------------------------
# VARIABLES FOR INSTACNES|
#-------------------------
variable "instance_type" {
  type        = string
  description = "instance type"
}

variable "key_name" {
  type        = string
  description = "key name"
}

# alb security group ingress port
variable "ingress_ports" {
  type = list(string)
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
variable "launch_config_name" {
  type = string
}
variable "health_check_grace_period" {
  type = string
  description = "health_check_grace_period value"
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