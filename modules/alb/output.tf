output "dns_name" {
  value       = aws_lb.my_alb.dns_name
  description = "Application load balancer dns name."
}

output "target_group_arn" {
  value       = aws_lb_target_group.my_tg.arn
  description = "target group arn"
}

output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "application loadbalancer security group id"
}