resource "aws_iam_role" "eks_test_role" {
  name               = "eks_test_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  role       = aws_iam_role.eks_test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "iam_attachment" {
  role       = aws_iam_role.eks_test_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_instance_profile" "eks_profile" {
  name = "eks_profile"
  role = aws_iam_role.eks_test_role.name
}
