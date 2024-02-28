resource "aws_eks_cluster" "eks" {
  name     = "pc1-eks"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [aws_subnet.public-subnet.id, aws_subnet.private-subnet.id]
  }

   depends_on = [
    aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy
  ]
}