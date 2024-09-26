# output "public_ip" {
#   value = aws_eip.main.public_ip
# }

# output "instance_private_ip_addr" {
#   value = aws_instance.main.private_ip
# }

# output "instance_public_ip_addr" {
#   value = aws_instance.main.public_ip
# }

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.kms.key_arn
}

output "kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.kms.key_id
}

output "kms_key_policy" {
  description = "The IAM resource policy set on the key"
  value       = module.kms.key_policy
}
