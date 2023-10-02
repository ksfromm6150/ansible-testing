module "functions_stage" {
    source = "../../modules/functions"

    vpc_subnet_ids         = var.vpc_subnet_ids
    vpc_security_group_ids = var.vpc_security_group_ids

    image_test = var.image_test
    image_TEST2 = var.image_TEST2

}