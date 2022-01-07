# publict subnet ids
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

# alb dns name
output "alb_dns" {
  value = module.alb.dns_name

}

# rds endpoint
output "rds_endoint" {
  value = module.rds.rds_endpoint
}