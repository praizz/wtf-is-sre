locals {
  cluster_name = var.cluster_name
  argocd_repositories = [
    {
      url  =  "https://github.com/praizz/wtf-gitops" 
    },
  ]
}

module "wtf_vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = "wtf-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "wtf_eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = module.wtf_vpc.private_subnets
  vpc_id          = module.wtf_vpc.vpc_id

  worker_groups = [
    {
      instance_type = "t3.small"
      asg_desired_capacity = "1"
      asg_max_size  = "2"
      asg_min_size  = "1"
    }
  ]
  workers_group_defaults = {
  	root_volume_type = "gp2"
  }
}

# run 'aws eks update-kubeconfig ...' locally and update local kube config
resource "null_resource" "update_kubeconfig" {
  depends_on = [
  module.wtf_eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${local.cluster_name} --region ${var.aws_region}"
  }
}

module "argocd" {
  source             = "DeimosCloud/argocd/kubernetes"
  version            = "1.0.0"
  repositories       = local.argocd_repositories
  module_depends_on  = [module.wtf_eks]
}

