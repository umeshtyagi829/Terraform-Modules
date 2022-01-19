#------------------------------
# Security Group for WebServer|
#------------------------------
resource "aws_security_group" "webserver_sg" {
  name        = var.security_group_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = var.alb_sg_id
  }

  egress {
    description = "Allow all outbount traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.tag_prefix}InstanceSecurityGroup"
  }
}

#---------------------
# Auto Scaling Group |
#---------------------
resource "aws_autoscaling_group" "asg" {
  name                      = var.autoscaling_group_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desire_size
  target_group_arns         = var.target_group_arn
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = var.subnets_ids
  
  tag {
    key = "Name"
    value = "${var.tag_prefix}AutoScalingGroup"
    propagate_at_launch = true

  }
  dynamic "tag" {
    for_each = var.default_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  # tags = merge(
  #   var.default_tags,
  #   {
  #    Name = "AutoScalingGroup"
  #   },
  # )

  # tag {
  #   key                 = "Name"
  #   value               = "${var.tag_prefix}AutoScalingGroup"
  #   propagate_at_launch = true
  # }

}

#-----------------------
# Launch Configuration |
#-----------------------
resource "aws_launch_configuration" "launch_config" {
  name_prefix     = var.launch_config_name
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  user_data       = var.user_data
  security_groups = [aws_security_group.webserver_sg.id]
  lifecycle {
    create_before_destroy = true
  }
}