
resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/eks/${var.cluster_name}/cluster"

  retention_in_days = 7
}

data "aws_iam_policy_document" "assume_eks_iam_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_iam_role" {
  name = "eks_role_${var.cluster_name}"

  assume_role_policy = data.aws_iam_policy_document.assume_eks_iam_role.json
}

data "aws_iam_policy" "AmazonEKSServicePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy_document" "write_logs" {
  statement {
    resources = [
      "${aws_cloudwatch_log_group.this.arn}",
      "${aws_cloudwatch_log_group.this.arn}*"
    ]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DeleteLogGroup",
      "logs:DeleteLogStream",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
      "logs:TagLogGroup",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  role       = aws_iam_role.eks_iam_role.name
  policy_arn = data.aws_iam_policy.AmazonEKSServicePolicy.arn
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_iam_role.name
  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
}

resource "aws_iam_policy" "write_logs" {
  name   = "write_logs_${var.cluster_name}"
  policy = data.aws_iam_policy_document.write_logs.json
}

resource "aws_iam_role_policy_attachment" "write_logs" {
  role       = aws_iam_role.eks_iam_role.name
  policy_arn = aws_iam_policy.write_logs.arn
}

resource "aws_eks_cluster" "this" {
  name = var.cluster_name

  role_arn = aws_iam_role.eks_iam_role.arn
  version  = "1.14"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = var.public_endpoint
    subnet_ids              = var.subnet_ids
  }

  enabled_cluster_log_types = [
    "api",
    "authenticator",
    "scheduler"
  ]

  depends_on = [aws_cloudwatch_log_group.this]

  timeouts {
    create = "1h"
    update = "2h"
    delete = "2h"
  }
}
