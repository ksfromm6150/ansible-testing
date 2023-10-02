module "functions_stage" {
    source = "../../modules/functions"

    vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids
}