module "functions_dev" {
    source = "../../modules/functions"

    vpc_subnet_ids         = var.vpc_subnet_ids
    vpc_security_group_ids = var.vpc_security_group_ids

    image_function1 = var.image_function1
    image_function2 = var.image_function2
    image_function3 = var.image_function3
    image_function4 = var.image_function4

}