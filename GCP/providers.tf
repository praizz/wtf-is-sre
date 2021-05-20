provider "google" {
  project      = "deimos-cloud"
  region       = "us-west1"
  credentials  =  file(var.credentials)
}

provider "kubernetes" {
  load_config_file       = false
  host                   = module.gke.endpoint
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = module.gke.endpoint
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = module.gke.cluster_ca_certificate
  }
}
