locals {
  argocd_repositories = [
    {
      url  =  "https://github.com/praizz/wtf-gitops" 
    },
  ]
}

module "argocd" {
  source             = "DeimosCloud/argocd/kubernetes"
  version            = "1.0.0"
  repositories       = local.argocd_repositories
  module_depends_on  = [module.gke]
}

module "wtf_vpc" {
  source         = "gruntwork-io/network/google//modules/vpc-network"
  version        = "0.8.0"
  project        = var.project_id
  region         = var.location
  name_prefix    = var.vpc_prefix

}

module "gke" {
  source                       = "gruntwork-io/gke/google//modules/gke-cluster"
  project                      = var.project_id
  location                     = var.location
  name                         = var.gke_name
  network                      = module.wtf_vpc.network #"A reference (self link) to the VPC network to host the cluster in"
  subnetwork                   = module.wtf_vpc.public_subnetwork #"A reference (self link) to the subnetwork to host the cluster in"
  cluster_secondary_range_name =  module.wtf_vpc.public_subnetwork_secondary_range_name  #"The name of the secondary range within the subnetwork for the cluster to use"
}

resource "google_container_node_pool" "primary_node" {
  name       = "wtf-node-pool"
  location   = var.location
  cluster    = module.gke.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}















