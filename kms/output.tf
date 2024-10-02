output "region" {
  description = "AWS region"
  value       = var.region
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.kms.key_arn
}

output "kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.kms.key_id
}

# output "kms_key_policy" {
#   description = "The IAM resource policy set on the key"
#   value       = module.kms.key_policy
# }
