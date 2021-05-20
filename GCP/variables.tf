variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
  default     = "deimos-cloud"
}

variable "location" {
  description = "The location (region or zone) to host the cluster in"
  type        = string
  default     = "us-west1"
}

variable "gke_name" {
  description = "The name of the cluster"
  type        = string
  default     = "wtf-gke"
}

variable "vpc_prefix" {
  description = "The name of the cluster"
  type        = string
  default     = "wtf-vpc"
}

variable "credentials" {
  description = "Path to service account file(.json)"
  type        = string
  default     = "sa.json"
}


variable "public_subnetwork_secondary_range_name" {
  description = "The name associated with the pod subnetwork secondary range, used when adding an alias IP range to a VM instance. The name must be 1-63 characters long, and comply with RFC1035. The name must be unique within the subnetwork."
  type        = string
  default     = "wtf-vpc-public-cluster"
}
variable "public_services_secondary_range_name" {
  description = "The name associated with the services subnetwork secondary range, used when adding an alias IP range to a VM instance. The name must be 1-63 characters long, and comply with RFC1035. The name must be unique within the subnetwork."
  type        = string
  default     = "wtf-vpc-public-services"
}


variable "service_account" {
  description = "SA email for node pool"
  type        = string
  default     = "wtf-sre@deimos-cloud.iam.gserviceaccount.com"
}

