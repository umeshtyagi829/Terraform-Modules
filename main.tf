locals {
  # Common tags to be assigned to all resources
  common_tags = {
    environment = "training"
    Owner       = "utyagi@presidio.com"
  }
}
#------------
# VPC MODULE|
#------------
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  tag_prefix = "umesh/"
  tags = local.common_tags
}

# -----------
# EC2 MODULE|
# -----------
module "ec2" {
  source                 = "./modules/ec2"
  vpc_id                 = module.vpc.vpc_id
  ami_id                 = data.aws_ami.amazon_linux.id
  subnets_ids            = module.vpc.private_subnet_ids
  instance_type          = var.instance_type
  key_name               = var.key_name
  target_group_arn       = [module.alb.target_group_arn]
  max_size               = 3
  min_size               = 1
  desire_size            = 1
  launch_config_name     = "mycf"
  alb_sg_id              = [module.alb.alb_sg_id]
  user_data              = <<EOF
                            #! /bin/bash
                            sudo yum update -y
                            sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                            sudo yum install -y httpd mariadb-server git
                            sudo systemctl start httpd
                            sudo systemctl enable httpd
                            sudo echo "<h1>Deployed by Umesh</h1>" > /var/www/html/index1.html
                            git clone https://github.com/umeshtyagi829/php-mysql-connection.git /tmp/php
                            sudo mv /tmp/php/index.php /var/www/html/
                            sudo systemctl restart httpd
                            EOF
  tag_prefix = "umesh/"
  tags = local.common_tags
}

# -----------
# ALB MODULE|
# -----------
module "alb" {
  source            = "./modules/alb"
  name              = var.alb_name
  subnets_ids       = module.vpc.public_subnet_ids
  target_group_name = var.target_group_name
  ingress_ports = var.sg_ports
  vpc_id            = module.vpc.vpc_id
  tag_prefix = "umesh/"
  tags = local.common_tags
    
}

# -----------
# RDS MODULE|
# -----------
module "rds" {
  source              = "./modules/rds"
  subnet_group_name   = var.subnet_group_name
  subnet_ids          = module.vpc.private_subnet_ids
  identifier          = var.rds_instance_name
  db_instance_class   = "db.t3.micro"
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_name = var.security_group_name
  vpc_id              = module.vpc.vpc_id
  allowed_cidrs       = module.vpc.public_subnet_cidrs
  webserver_sg_id     = [module.ec2.webserver_sg_id]
  tag_prefix = "umesh/"
  tags = local.common_tags
}
