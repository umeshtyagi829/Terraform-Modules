#--------------
# SUBNET GROUP|
#--------------
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.tag_prefix}DBSubnetGroup"
  }
}
#--------------
# RDS INSTANCE|
#--------------
resource "aws_db_instance" "my_rds" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  multi_az               = var.multi_az
  tags = {
    Name = "${var.tag_prefix}RDSInstance"
  }
}

#-----------------------------
# SECURITY GROUP FOR DATABASE|
#-----------------------------
resource "aws_security_group" "db_sg" {
  name   = var.security_group_name
  vpc_id = var.vpc_id
  ingress {
    from_port       = var.from_port
    to_port         = var.to_port
    protocol        = var.protocol
    security_groups = var.webserver_sg_id
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "${var.tag_prefix}DBSecurityGroup"
  }
}