resource "aws_lb" "alb" {
  name               = "private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.private_subnet_1_id, var.private_subnet_2_id]

  idle_timeout               = 300
  drop_invalid_header_fields = true

  access_logs {
    bucket  = var.lb_access_logs_bucket
    prefix  = "private-alb"
    enabled = true
  }

  tags = {
    Name = var.alb_name
  }
}

# See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-update-security-groups.html
resource "aws_security_group" "alb" {
  name        = "General Private Load Balancer"
  vpc_id      = var.vpc_id
  description = "Sec group for the private ALB"

  tags = {
    Name = "general_private_alb_secgroup"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_http_all" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow HTTP"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "private_alb_allow_https_all"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_https_all" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow HTTPS"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "private_alb_allow_https_all"
  }
}


resource "aws_vpc_security_group_ingress_rule" "alb_allow_lb_internal" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow 6000 for private lb"
  from_port         = 6000
  to_port           = 6000
  ip_protocol       = "tcp"
  cidr_ipv4         = var.vpc_cidr_block
  tags = {
    Name = "private_alb_allow_https_epfl"
  }
}

# TODO limit to only the listener ports and health check ports of the instance groups
resource "aws_vpc_security_group_egress_rule" "alb_allow_everything_outgoing" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow everything outgoing"
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "private_alb_allow_everything_outgoing"
  }
}

