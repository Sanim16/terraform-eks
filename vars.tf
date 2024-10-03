variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the cluster"
  default = "dev-cluster"
}

variable "cluster_version" {
  description = "The version of the cluster"
  default = "1.30"
}

variable "user" {
  description = "AWS IAM user to give admin rights to via access entries"
  # default = ""
}

variable "owner" {
  description = "my aws IAM user to add to the admin rights to"
  # default = ""
}

variable "aws_account_id" {
  description = "my aws account id"
  # default = ""
}
