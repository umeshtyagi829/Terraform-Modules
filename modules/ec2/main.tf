#---------------------------------------
# CREATE A SECURITY GROUP FOR WEBSERVER|
#---------------------------------------
resource "aws_security_group" "webserver_sg" {
  name        = var.security_group_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.instance_ingress_ports
    iterator = port
    content {
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.instance_ssh_cidr
  }
  egress {
    description      = "Allow all outbount traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = var.tags
}

#----------------------------------------
# CREATE TWO EC2 INSTANCES FOR WEBSERVER|
#----------------------------------------
locals {
  subnets = var.subnets_ids
  length  = length(local.subnets)
  launch_subnets = [
    for i in range(var.instance_count) :
    local.subnets[i % local.length]
  ]
}
resource "aws_instance" "web_server" {
  count                       = var.instance_count
  subnet_id                   = local.launch_subnets[count.index]
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  tags                        = var.tags
}