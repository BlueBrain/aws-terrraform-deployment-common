# The outputs defined here can be used by other modules/repos

output "aws_region" {
  description = "AWS region to use"
  value       = var.aws_region
}

output "aws_coreservices_ssh_key_id" {
  description = "ID of the SSH key aws_resources"
  value       = aws_key_pair.aws_coreservices.id
}

output "aws_coreservices_ssh_key_arn" {
  description = "ARN of the SSH key aws_resources"
  value       = aws_key_pair.aws_coreservices.arn
}

output "internet_gateway_id" {
  description = "ID of the internet gateway for public subnets"
  value       = module.network.internet_gateway_id
}

output "internet_gateway_arn" {
  description = "ARN of the internet gateway for public subnets"
  value       = module.network.internet_gateway_arn
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway for private networks"
  value       = module.network.nat_gateway_id
}

output "public_a_subnet_id" {
  description = "ID of the public_a subnet"
  value       = module.network.public_1_subnet_id
  sensitive   = false
}

output "public_a_subnet_arn" {
  description = "ARN of the public_a subnet"
  value       = module.network.public_1_subnet_arn
}

output "public_b_subnet_id" {
  description = "ID of the public_b subnet"
  value       = module.network.public_2_subnet_id
}

output "public_b_subnet_arn" {
  description = "ARN of the public_b subnet"
  value       = module.network.public_2_subnet_arn
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = module.network.vpc_arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block or network range of the VPC"
  value       = module.network.vpc_cidr_block
}

output "vpc_default_sg_id" {
  description = "ID of the Default Security Group for the VPC"
  value       = module.network.vpc_default_sg_id
}

output "bbpproxy_cidr" {
  description = "CIDR of bbpproxy.epfl.ch"
  value       = var.bbpproxy_cidr
}

output "route_table_private_subnets_arn" {
  description = "ARN of the route table for all private subnets in the main region"
  value       = module.network.private_route_table_arn
}

output "route_table_private_subnets_id" {
  description = "ID of the route table for all private subnets in the main region"
  value       = module.network.private_route_table_id
}

output "private_alb_sg_id" {
  description = "Id of ALB security group"
  value       = module.private_alb_basic.alb_securitygroup_id
}

output "public_nlb_sg_id" {
  description = "Id of NLB security group"
  value       = module.public_nlb_basic.nlb_securitygroup_id
}

output "primary_domain" {
  description = "Primary platform domain"
  value       = module.primary_domain.domain_name
  sensitive   = false
}

output "domain_zone_id" {
  description = "zone_id of the domain shapes-registry.org"
  value       = module.alt_domain_shapes-registry_org.domain_zone_id
  sensitive   = false
}

output "private_alb_https_listener_arn" {
  description = "ARN of the private ALB"
  value       = module.private_alb_basic.alb_https_listener_arn
}

output "private_alb_security_group_id" {
  description = "ID of the SG of the private ALB"
  value       = aws_security_group.private_alb.id
}

output "generic_private_alb_security_group_id" {
  description = "Id of the SG of the new private ALB"
  value       = module.private_alb_basic.alb_securitygroup_id
}

output "resource_provisioner_ecr_url" {
  description = "URL of the ECR for HPC Resource Provisioner"
  value       = module.ecr.resource_provisioner_ecr_url
}
