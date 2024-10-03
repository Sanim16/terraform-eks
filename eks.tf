###############################################################################
# EKS
###############################################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
    }
  }

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  # control_plane_subnet_ids = data.terraform_remote_state.vpc.outputs.intra_subnet_ids


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m5.large", "m5n.large", "m5zn.large", "t3.small", "t3.medium"]
  }

  eks_managed_node_groups = {
    first = {
      name = "node-grp-1"

      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 10
      desired_size = 3

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 20
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 125
            encrypted             = true
            kms_key_id            = data.terraform_remote_state.kms.outputs.kms_key_arn
            delete_on_termination = true
          }
        }
      }
    }
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

  create_kms_key = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = data.terraform_remote_state.kms.outputs.kms_key_arn
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}


###############################################################################
# EBS CSI
###############################################################################
module "ebs_csi_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.44.0"

  role_name = "one-ebs-csi"

  attach_ebs_csi_policy = true
  ebs_csi_kms_cmk_ids   = [data.terraform_remote_state.kms.outputs.kms_key_arn]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

data "aws_eks_addon_version" "ebs_csi" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = "1.30"
  most_recent        = true
}

# resource "aws_eks_addon" "ebs_csi" {
#   cluster_name = module.eks.cluster_name
#   addon_name   = "aws-ebs-csi-driver"

#   addon_version               = data.aws_eks_addon_version.ebs_csi.version
#   resolve_conflicts_on_update = "PRESERVE"
#   service_account_role_arn    = module.ebs_csi_irsa_role.iam_role_arn

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }

###############################################################################
# Storage Class
###############################################################################
resource "kubectl_manifest" "ebs_csi_default_storage_class" {
  yaml_body = <<-YAML
  apiVersion: storage.k8s.io/v1
  kind: StorageClass
  metadata:
    annotations:
      storageclass.kubernetes.io/is-default-class: "true"
    name: gp3-default
  provisioner: ebs.csi.aws.com
  reclaimPolicy: Delete
  volumeBindingMode: WaitForFirstConsumer
  allowVolumeExpansion: true
  parameters:
    type: gp3  
    fsType: ext4
    encrypted: "true"
    kmsKeyId: "${data.terraform_remote_state.kms.outputs.kms_key_arn}"
  YAML
}
