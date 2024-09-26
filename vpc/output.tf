output "private_subnet_ids" {
  value = module.vpc.private_subnets
  description = "private subnet ids"
}

output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The VPC ID"
}

output "security_group_id" {
  value = aws_security_group.terraform-dev-vpc.id
  description = "The security group ID"
}

# azs

# Description: A list of availability zones specified as argument to this module

# default_route_table_id

# Description: The ID of the default route table

# default_vpc_arn

# Description: The ARN of the Default VPC

# default_vpc_cidr_block

# Description: The CIDR block of the Default VPC

# default_vpc_default_route_table_id

# Description: The ID of the default route table of the Default VPC
# default_vpc_default_security_group_id

# Description: The ID of the security group created by default on Default VPC creation
# default_vpc_enable_dns_hostnames

# Description: Whether or not the Default VPC has DNS hostname support
# default_vpc_enable_dns_support

# Description: Whether or not the Default VPC has DNS support
# default_vpc_id

# Description: The ID of the Default VPC
# default_vpc_instance_tenancy

# Description: Tenancy of instances spin up within Default VPC
# default_vpc_main_route_table_id

# Description: The ID of the main route table associated with the Default VPC
# dhcp_options_id

# Description: The ID of the DHCP options
# egress_only_internet_gateway_id

# Description: The ID of the egress only Internet Gateway
# elasticache_network_acl_arn

# Description: ARN of the elasticache network ACL
# elasticache_network_acl_id

# Description: ID of the elasticache network ACL
# elasticache_route_table_association_ids

# Description: List of IDs of the elasticache route table association
# elasticache_route_table_ids

# Description: List of IDs of elasticache route tables
# elasticache_subnet_arns

# Description: List of ARNs of elasticache subnets
# elasticache_subnet_group

# Description: ID of elasticache subnet group
# elasticache_subnet_group_name

# Description: Name of elasticache subnet group
# elasticache_subnets

# Description: List of IDs of elasticache subnets
# elasticache_subnets_cidr_blocks

# Description: List of cidr_blocks of elasticache subnets
# elasticache_subnets_ipv6_cidr_blocks

# Description: List of IPv6 cidr_blocks of elasticache subnets in an IPv6 enabled VPC
# igw_arn

# Description: The ARN of the Internet Gateway
# igw_id

# Description: The ID of the Internet Gateway
# intra_network_acl_arn

# Description: ARN of the intra network ACL
# intra_network_acl_id

# Description: ID of the intra network ACL
# intra_route_table_association_ids

# Description: List of IDs of the intra route table association
# intra_route_table_ids

# Description: List of IDs of intra route tables
# intra_subnet_arns

# Description: List of ARNs of intra subnets
# intra_subnets

# Description: List of IDs of intra subnets
# intra_subnets_cidr_blocks

# Description: List of cidr_blocks of intra subnets
# intra_subnets_ipv6_cidr_blocks

# Description: List of IPv6 cidr_blocks of intra subnets in an IPv6 enabled VPC
# name

# Description: The name of the VPC specified as argument to this module
# nat_ids

# Description: List of allocation ID of Elastic IPs created for AWS NAT Gateway
# nat_public_ips

# Description: List of public Elastic IPs created for AWS NAT Gateway
# natgw_ids

# Description: List of NAT Gateway IDs
# natgw_interface_ids

# Description: List of Network Interface IDs assigned to NAT Gateways
# outpost_network_acl_arn

# Description: ARN of the outpost network ACL
# outpost_network_acl_id

# Description: ID of the outpost network ACL
# outpost_subnet_arns

# Description: List of ARNs of outpost subnets
# outpost_subnets

# Description: List of IDs of outpost subnets
# outpost_subnets_cidr_blocks

# Description: List of cidr_blocks of outpost subnets
# outpost_subnets_ipv6_cidr_blocks

# Description: List of IPv6 cidr_blocks of outpost subnets in an IPv6 enabled VPC
# private_ipv6_egress_route_ids

# Description: List of IDs of the ipv6 egress route
# private_nat_gateway_route_ids

# Description: List of IDs of the private nat gateway route
# private_network_acl_arn

# Description: ARN of the private network ACL
# private_network_acl_id

# Description: ID of the private network ACL
# private_route_table_association_ids

# Description: List of IDs of the private route table association
# private_route_table_ids

# Description: List of IDs of private route tables
# private_subnet_arns

# Description: List of ARNs of private subnets
# private_subnets

# Description: List of IDs of private subnets
# private_subnets_cidr_blocks

# Description: List of cidr_blocks of private subnets
# private_subnets_ipv6_cidr_blocks

# Description: List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC
# public_internet_gateway_ipv6_route_id

# Description: ID of the IPv6 internet gateway route
# public_internet_gateway_route_id

# Description: ID of the internet gateway route
# public_network_acl_arn

# Description: ARN of the public network ACL
# public_network_acl_id

# Description: ID of the public network ACL
# public_route_table_association_ids

# Description: List of IDs of the public route table association
# public_route_table_ids

# Description: List of IDs of public route tables
# public_subnet_arns

# Description: List of ARNs of public subnets
# public_subnets

# Description: List of IDs of public subnets
# public_subnets_cidr_blocks

# Description: List of cidr_blocks of public subnets
# public_subnets_ipv6_cidr_blocks

# Description: List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC
# redshift_network_acl_arn

# Description: ARN of the redshift network ACL
# redshift_network_acl_id

# Description: ID of the redshift network ACL
# redshift_public_route_table_association_ids

# Description: List of IDs of the public redshift route table association
# redshift_route_table_association_ids

# Description: List of IDs of the redshift route table association
# redshift_route_table_ids

# Description: List of IDs of redshift route tables
# redshift_subnet_arns

# Description: List of ARNs of redshift subnets
# redshift_subnet_group

# Description: ID of redshift subnet group
# redshift_subnets

# Description: List of IDs of redshift subnets
# redshift_subnets_cidr_blocks

# Description: List of cidr_blocks of redshift subnets
# redshift_subnets_ipv6_cidr_blocks

# Description: List of IPv6 cidr_blocks of redshift subnets in an IPv6 enabled VPC
# this_customer_gateway

# Description: Map of Customer Gateway attributes
# vgw_arn

# Description: The ARN of the VPN Gateway
# vgw_id

# Description: The ID of the VPN Gateway
# vpc_arn

# Description: The ARN of the VPC
# vpc_cidr_block

# Description: The CIDR block of the VPC
# vpc_enable_dns_hostnames

# Description: Whether or not the VPC has DNS hostname support
# vpc_enable_dns_support

# Description: Whether or not the VPC has DNS support
# vpc_flow_log_cloudwatch_iam_role_arn

# Description: The ARN of the IAM role used when pushing logs to Cloudwatch log group
# vpc_flow_log_deliver_cross_account_role

# Description: The ARN of the IAM role used when pushing logs cross account
# vpc_flow_log_destination_arn

# Description: The ARN of the destination for VPC Flow Logs
# vpc_flow_log_destination_type

# Description: The type of the destination for VPC Flow Logs
# vpc_flow_log_id

# Description: The ID of the Flow Log resource
# vpc_id

# Description: The ID of the VPC
# vpc_instance_tenancy

# Description: Tenancy of instances spin up within VPC
# vpc_ipv6_association_id

# Description: The association ID for the IPv6 CIDR block
# vpc_ipv6_cidr_block

# Description: The IPv6 CIDR block
# vpc_main_route_table_id

# Description: The ID of the main route table associated with this VPC
# vpc_owner_id

# Description: The ID of the AWS account that owns the VPC
# vpc_secondary_cidr_blocks

# Description: List of secondary CIDR blocks of the VPC
