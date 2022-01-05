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

variable "security_group_name" {
  type        = string
  description = "ALB SG name."
  default     = "alb-security-group"
}

variable "ingress_ports" {
  description = "ingress ports"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}

variable "tag_prefix" {
  type = string
  default = ""
  description = "tag prefix"

}