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

variable "image_test" {
  description = "ECR image URI for the named lambda"
  type        = string
}
variable "image_TEST2" {
  description = "ECR image URI for the named lambda"
  type        = string
}
