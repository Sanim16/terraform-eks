output "intra_subnet_ids" {
  value       = module.vpc.intra_subnets
  description = "private subnet ids"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "public subnet ids"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "private subnet ids"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The VPC ID"
}

output "security_group_id" {
  value       = aws_security_group.terraform-dev-vpc.id
  description = "The security group ID"
}
