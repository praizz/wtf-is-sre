data "aws_eks_cluster" "wtf_cluster" {
  name = module.wtf_eks.cluster_id
}

data "aws_eks_cluster_auth" "wtf_cluster" {
  name = module.wtf_eks.cluster_id
}