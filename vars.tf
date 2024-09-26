variable "vpc_cidr" {
  type        = string
  description = "cidr block for the vpc"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "cidr block for the subnet"
  default     = "10.0.1.0/24"
}

variable "region" {
  default = "us-east-1"
}

variable "user" {
  description = "my aws IAM user to add to the admin rights to"
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
