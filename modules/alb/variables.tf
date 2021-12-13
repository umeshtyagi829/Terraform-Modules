variable "name" {
  type        = string
  description = "Name of Application load balancer."
}
variable "subnets_ids" {
  description = "IDs of subnets for ALB."
  type        = list(string)
}

variable "target_group_name" {
  description = "target group name."
  type        = string
}
variable "vpc_id" {
  description = "VPC id for TG."
  type        = string
}

variable "target_instance_count" {
  description = "Count of targets for attachment."
  type        = number
}
variable "target_ids" {
  description = "IDs of targets for attachment."
  type        = list(string)
}

variable "security_group_name" {
  type        = string
  description = "ALB SG name."
  default     = "alb-security-group"
}


variable "tags" {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}