variable "cluster_name" {
  type        = string
  description = "the EKS cluster name"
  default     = "wtf-eks"
}

variable "aws_region" {
  type        = string
  description = "the AWS region to create all the resources"
  default     = "eu-west-3"
}