module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-dev-cluster"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver = {
      # addon_version = "v1.35.0-eksbuild.1"
      most_recent = true
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" #IAM rights needed by CSI driver
      }
    }

  }

  create_kms_key = false

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  eks_managed_node_group_defaults = {
    ami_type       = "AL2023_x86_64_STANDARD"
    instance_types = ["m5.large", "m5n.large", "m5zn.large", "t3.small", "t3.medium"]

    disk_size = 50
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = 50
          volume_type           = "gp3"
          iops                  = 3000
          throughput            = 150
          encrypted             = true
          delete_on_termination = true
          kms_key_id            = module.kms.key_arn
        }
      }
    }
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small", "t3.medium"]

      min_size     = 1
      max_size     = 10
      desired_size = 3

      iam_role_additional_policies = {
        policy_arn               = "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
        policy_arn1              = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" #IAM rights needed by CSI driver
      }

      # ami_type       = "AL2023_x86_64_STANDARD"
      # instance_types = ["t3.medium"]

      # min_size     = 2
      # max_size     = 10
      # desired_size = 2

      # block_device_mappings = {
      #   xvda = {
      #     device_name = "/dev/xvda"
      #     ebs = {
      #       volume_size           = 20
      #       volume_type           = "gp3"
      #       iops                  = 3000
      #       throughput            = 125
      #       encrypted             = true
      #       kms_key_id            = module.kms.key_arn
      #       delete_on_termination = true
      #     }
      #   }
      # }
    }

    # two = {
    #   name = "node-group-2"

    #   # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
    #   ami_type = "AL2023_x86_64_STANDARD"
    #   instance_types = ["t3.small"]

    #   min_size     = 1
    #   max_size     = 2
    #   desired_size = 1
    # }
  }

  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = var.user
      # principal_arn = "arn:aws:iam::123456789012:role/something"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

data "aws_caller_identity" "current" {}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "3.1.0"

  description = "EKS Cluster"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  key_administrators                = [data.aws_caller_identity.current.arn, var.owner]
  key_owners                        = [data.aws_caller_identity.current.arn, var.owner]
  key_service_roles_for_autoscaling = ["arn:aws:iam::${var.aws_account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]

  # Aliases
  aliases = ["eks/my-dev-cluster"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
