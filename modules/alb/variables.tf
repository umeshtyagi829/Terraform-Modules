variable "name" {
  type        = string
  description = "Name of Application load balancer."
  default     = ""
}
variable "subnets_ids" {
  description = "IDs of subnets for ALB."
  type        = list(string)
}

variable "load_balancer_type" {
  description = "choose load balancer type"
  default     = "application"
  type        = string
}

variable "internal" {
  type    = bool
  default = false
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "target_group_name" {
  description = "target group name."
  type        = string
  default     = ""
}
variable "vpc_id" {
  description = "VPC id for TG."
  type        = string
}

variable "security_group_name" {
  type        = string
  description = "ALB SG name."
  default     = ""
}

variable "ingress_ports" {
  description = "ingress ports"
  type        = list(string)
  default     = [80]
}

variable "tag_prefix" {
  type        = string
  default     = ""
  description = "tag prefix"
}

variable "target_group_port" {
  type    = string
  default = 80
}

variable "target_group_protocol" {
  type    = string
  default = "HTTP"
}

variable "heath_check_path" {
  type    = string
  default = "/"
}

variable "heath_check_port" {
  type    = string
  default = 80
}

variable "heath_check_healthy_threshold" {
  type    = string
  default = 3
}

variable "heath_check_unhealthy_threshold" {
  type    = string
  default = 2
}

variable "heath_check_timeout" {
  type    = string
  default = 10
}
variable "heath_check_interval" {
  type    = string
  default = 30
}
variable "heath_check_matcher" {
  type    = string
  default = "200"
}

variable "cidr_blocks" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "protocol" {
  type = string
  default = "tcp"
}