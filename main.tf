#------------
# VPC MODULE|
#------------
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  tags = {
    Name        = "umesh"
    environment = "training"
    Owner       = "utyagi@presidio.com"
  }
}

# -----------
# EC2 MODULE|
# -----------
module "ec2" {
  source                      = "./modules/ec2"
  vpc_id                      = module.vpc.vpc_id
  instance_count              = 1
  ami_id                      = data.aws_ami.amazon_linux.id
  subnets_ids                 = module.vpc.public_subnet_ids
  instance_type               = var.instance_type
  key_name                    = var.key_name
  instance_ingress_ports      = var.sg_ports
  instance_ssh_cidr           = ["${var.ssh_client}"]
  associate_public_ip_address = true
  user_data                   = <<EOF
                #! /bin/bas
                sudo yum update -y
                sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                sudo yum install -y httpd mariadb-server
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo echo DB_HOST=${module.rds.rds_endpoint} >> /etc/environment
                sudo echo DB_NAME=${var.db_name} >> /etc/environment
                sudo echo DB_USERNAME=${var.db_username} >> /etc/environment
                sudo echo DB_PASSWORD=${var.db_pass} >> /etc/environment
                sudo source /etc/environment
                sudo yum install git -y
                git clone https://github.com/umeshtyagi829/deploy_two_tier_app_in_container.git /tmp/code
                sudo mv /tmp/code/php/code/*  /var/www/html
                sudo systemctl restart httpd
	            EOF

  tags = {
    Name        = "umesh"
    environment = "training"
    Owner       = "utyagi@presidio.com"
  }
}

# -----------
# ALB MODULE|
# -----------
module "alb" {
  source                = "./modules/alb"
  name                  = var.alb_name
  subnets_ids           = module.vpc.public_subnet_ids
  target_group_name     = var.target_group_name
  vpc_id                = module.vpc.vpc_id
  target_instance_count = module.ec2.instance_count
  target_ids            = module.ec2.instance_ids
  tags = {
    Name        = "umesh"
    environment = "training"
    Owner       = "utyagi@presidio.com"
  }
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
  db_password         = var.db_pass
  security_group_name = var.security_group_name
  vpc_id              = module.vpc.vpc_id
  allowed_cidrs       = module.vpc.public_subnet_cidrs
  tags = {
    Name        = "umesh"
    environment = "training"
    Owner       = "utyagi@presidio.com"
  }
}