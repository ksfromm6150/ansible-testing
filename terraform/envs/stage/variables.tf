variable "environment" {
  description = "The environment: stage"
  default     = "stage"
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

variable "image_function1" {
  description = "ECR image URI for the named lambda"
  type        = string
}
variable "image_function2" {
  description = "ECR image URI for the named lambda"
  type        = string
}
variable "image_function3" {
  description = "ECR image URI for the named lambda"
  type        = string
}
variable "image_function4" {
  description = "ECR image URI for the named lambda"
  type        = string
}
