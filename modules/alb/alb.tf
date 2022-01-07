#------------------------------
# APPLICATION LOAD BALANCER   |
#------------------------------
resource "aws_lb" "my_alb" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.subnets_ids
  enable_deletion_protection = var.enable_deletion_protection
  tags = {
    Name = "${var.tag_prefix}ALB"
  }
}

#---------------
# TARGET GROUP |
#---------------
resource "aws_lb_target_group" "my_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.heath_check_path
    port                = var.heath_check_port
    healthy_threshold   = var.heath_check_healthy_threshold
    unhealthy_threshold = var.heath_check_unhealthy_threshold
    timeout             = var.heath_check_timeout
    interval            = var.heath_check_interval
    matcher             = var.heath_check_matcher # has to be HTTP 200 or fails
  }
}

#--------------
# ALB LISTNER |
#--------------
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my_tg.arn
    type             = "forward"
  }
}
#-------------------
# ALB LISTNER RULE |
#-------------------
resource "aws_alb_listener_rule" "alb_listener_rule" {
  depends_on = [
    aws_lb_target_group.my_tg,
  ]
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

#-----------------------------------------
# APPLICATION LOAD BALANCER SECURITY GROUP|
#-----------------------------------------
resource "aws_security_group" "alb_sg" {
  name   = var.security_group_name
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = var.protocol
      cidr_blocks = var.cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
  tags = {
    Name = "${var.tag_prefix}ALBSecurityGroup"
  }
}
