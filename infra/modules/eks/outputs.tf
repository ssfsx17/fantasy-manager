
output "eks_iam_role" {
  value = aws_iam_role.eks_iam_role
}

output "eks_cluster" {
  value = aws_eks_cluster.this
}
