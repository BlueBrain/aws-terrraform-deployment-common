resource "aws_lb" "alb" {
  name               = "public-alb"
  internal           = false #tfsec:ignore:aws-elb-alb-not-public
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  drop_invalid_header_fields = true

  tags = {
    Name        = "sbo-poc-alb",
    SBO_Billing = "common"
  }
}

# See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-update-security-groups.html
resource "aws_security_group" "alb" {
  name        = "Public load balancer"
  vpc_id      = aws_vpc.sbo_poc.id
  description = "Sec group for the public ALB"

  tags = {
    Name        = "alb_secgroup"
    SBO_Billing = "common"
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
    Name = "alb_allow_https_all"
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
    Name = "alb_allow_https_all"
  }
}

# TODO: expose aws_security_group.alb.id in the outputs
# and move Viz related ingress rules to the "deployment" repo.
resource "aws_vpc_security_group_ingress_rule" "alb_allow_brayns_epfl" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow Brayns on 5000 from EPFL"
  from_port         = 5000
  to_port           = 5000
  ip_protocol       = "tcp"
  cidr_ipv4         = var.epfl_cidr

  tags = {
    Name = "alb_allow_brayns_epfl"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_bcsb_epfl" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow BCSB on 8000 from EPFL"
  from_port         = 8000
  to_port           = 8000
  ip_protocol       = "tcp"
  cidr_ipv4         = var.epfl_cidr

  tags = {
    Name = "alb_allow_bcsb_epfl"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_vsm_epfl" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow VSM on 4444 from EPFL"
  from_port         = 4444
  to_port           = 4444
  ip_protocol       = "tcp"
  cidr_ipv4         = var.epfl_cidr

  tags = {
    Name = "alb_allow_vsm_epfl"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_vsm_proxy_epfl" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow VSM-Proxy on 8888 from EPFL"
  from_port         = 8888
  to_port           = 8888
  ip_protocol       = "tcp"
  cidr_ipv4         = var.epfl_cidr

  tags = {
    Name = "alb_allow_vsm_proxy_epfl"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_lb_internal" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow 6000 for public lb"
  from_port         = 6000
  to_port           = 6000
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.sbo_poc.cidr_block

  tags = {
    Name = "alb_allow_https_epfl"
  }
}

# TODO limit to only the listener ports and health check ports of the instance groups
resource "aws_vpc_security_group_egress_rule" "alb_allow_everything_outgoing" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow everything outgoing"
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Name = "alb_allow_everything_outgoing"
  }
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
