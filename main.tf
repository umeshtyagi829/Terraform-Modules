#------------
# VPC MODULE|
#------------
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  tag_prefix          = var.tag_prefix
}

# -----------
# EC2 MODULE|
# -----------
module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  ami_id             = data.aws_ami.amazon_linux.id
  subnets_ids        = module.vpc.private_subnet_ids
  instance_type      = var.instance_type
  key_name           = var.key_name
  target_group_arn   = [module.alb.target_group_arn]
  max_size           = var.max_size
  min_size           = var.min_size
  desire_size        = var.desire_size
  health_check_grace_period = var.health_check_grace_period
  launch_config_name = var.launch_config_name
  alb_sg_id          = [module.alb.alb_sg_id]
  default_tags       = var.default_tags
  tag_prefix         = var.tag_prefix
  user_data          = <<EOF
                        #! /bin/bash
                        sudo yum update -y
                        sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                        sudo yum install -y httpd mariadb-server git
                        sudo systemctl start httpd
                        sudo systemctl enable httpd
                        sudo echo SetEnv DB_HOST ${module.rds.rds_endpoint} >> /tmp/env.conf
                        sudo echo SetEnv MYSQL_DATABASE ${var.db_name} >> /tmp/env.conf
                        sudo echo SetEnv MYSQL_USER ${var.db_username} >> /tmp/env.conf
                        sudo echo SetEnv MYSQL_PASSWORD ${var.db_password} >> /tmp/env.conf
                        sudo mv /tmp/env.conf /etc/httpd/conf.d/env.conf
                        git clone https://github.com/umeshtyagi829/deploy_two_tier_app_in_container.git /tmp/code
                        sudo mv /tmp/code/php/code/*  /var/www/html
                        sudo systemctl restart httpd
                        EOF
}

# -----------
# ALB MODULE|
# -----------
module "alb" {
  source                     = "./modules/alb"
  name                       = var.alb_name
  subnets_ids                = module.vpc.public_subnet_ids
  vpc_id                     = module.vpc.vpc_id
  tag_prefix                 = var.tag_prefix
  load_balancer_type         = var.load_balancer_type
  internal                   = var.internal
  enable_deletion_protection = var.enable_deletion_protection

  ############# attributes for target group ###################
  target_group_name               = var.target_group_name
  target_group_port               = var.target_group_port
  target_group_protocol           = var.target_group_protocol
  heath_check_path                = var.heath_check_path
  heath_check_port                = var.heath_check_port
  heath_check_healthy_threshold   = var.heath_check_healthy_threshold
  heath_check_unhealthy_threshold = var.heath_check_unhealthy_threshold
  heath_check_timeout             = var.heath_check_timeout
  heath_check_interval            = var.heath_check_interval
  heath_check_matcher             = var.heath_check_matcher

  #############alb-sg#########################################
  ingress_ports = var.ingress_ports
  cidr_blocks   = var.cidr_blocks
  protocol      = var.protocol
}

# -----------
# RDS MODULE|
# -----------
module "rds" {
  source              = "./modules/rds"
  subnet_group_name   = var.subnet_group_name
  subnet_ids          = module.vpc.private_subnet_ids
  identifier          = var.rds_instance_name
  db_instance_class   = var.db_instance_class
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_name = var.security_group_name
  vpc_id              = module.vpc.vpc_id
  allowed_cidrs       = module.vpc.public_subnet_cidrs
  webserver_sg_id     = [module.ec2.webserver_sg_id]
  multi_az            = var.multi_az
  tag_prefix          = var.tag_prefix
}
