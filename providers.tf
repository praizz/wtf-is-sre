provider "aws" {
  region = "eu-west-3"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.wtf_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.wtf_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.wtf_cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.wtf_cluster.endpoint
    token                  = data.aws_eks_cluster_auth.wtf_cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.wtf_cluster.certificate_authority.0.data)
  }
}
