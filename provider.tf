terraform {

  backend "s3" {
    bucket         = "unique-bucket-name-msctf" # REPLACE WITH YOUR BUCKET NAME
    key            = "eks-remote-backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file = false
}

data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    data.aws_eks_cluster.cluster
  ]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "unique-bucket-name-msctf" # REPLACE WITH YOUR BUCKET NAME
    key            = "vpc-remote-backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    # encrypt        = true
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket         = "unique-bucket-name-msctf" # REPLACE WITH YOUR BUCKET NAME
    key            = "kms-remote-backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    # encrypt        = true
  }
}
