data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.terraform-eks.id]

  associate_public_ip_address = true

  availability_zone = "us-east-1a"
  key_name          = "terraformkey"

  tags = {
    Name = "main"
  }

  iam_instance_profile = "eks_profile"

  depends_on = [module.vpc]

  user_data = file("bootstrap.sh")
}

resource "aws_instance" "main1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[1]

  vpc_security_group_ids = [aws_security_group.terraform-eks.id]

  associate_public_ip_address = true

  availability_zone = "us-east-1a"
  key_name          = "terraformkey"

  tags = {
    Name = "main1"
  }

  iam_instance_profile = "eks_profile"

  depends_on = [module.vpc]

  user_data = file("bootstrap.sh")
}

data "aws_ami" "base_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "amazon" {
  ami           = data.aws_ami.base_ami.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[2]

  vpc_security_group_ids = [aws_security_group.terraform-eks.id]

  associate_public_ip_address = true

  availability_zone = "us-east-1a"
  key_name          = "terraformkey"

  tags = {
    Name = "amazon"
  }

  iam_instance_profile = "eks_profile"

  depends_on = [module.vpc]

  # user_data = file("bootstrap.sh")
}
