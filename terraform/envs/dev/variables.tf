variable "environment" {
  description = "The environment: dev"
  default     = "dev"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
  default     = null
}


/* images */

variable "image_collectrenewals" {
  type        = string
  description = "ECR image URI for the named lambda"
}

variable "image_customerlistener" {
  type        = string
  description = "ECR image URI for the named lambda"
}

variable "image_gatherrequests" {
  type        = string
  description = "ECR image URI for the named lambda"
}

variable "image_orderlistener" {
  type        = string
  description = "ECR image URI for the named lambda"
}

variable "image_quotedelivery" {
  type        = string
  description = "ECR image URI for the named lambda"
}

variable "image_vendorlistener" {
  type        = string
  description = "ECR image URI for the named lambda"
}

variable "image_workitemlistener" {
  type        = string
  description = "ECR image URI for the named lambda"
}

