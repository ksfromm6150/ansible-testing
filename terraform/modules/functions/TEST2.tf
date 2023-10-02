data "aws_iam_role" "TEST2" {
  name = "${local.name_prefix}-TEST2-${local.region}"
}

module "TEST2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${local.name_prefix}-TEST2"

  package_type   = "Image"
  image_uri      = var.image_TEST2
  create_package = false

  lambda_role     = data.aws_iam_role.TEST2.arn
  create_role     = false
  attach_policies = false

  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  image_config_command = ["ansible-testing.TEST2::ordermanagement.shared.ansible-testing.TEST2.Function::FunctionHandler"]

  publish = true
}

module "TEST2_alias" {
  source  = "terraform-aws-modules/lambda/aws//modules/alias"
  version = "~> 6.0"

  depends_on = [module.TEST2]

  name             = "current"
  function_name    = module.TEST2.lambda_function_name
  function_version = module.TEST2.lambda_function_version
}

module "TEST2_deploy" {
  source  = "terraform-aws-modules/lambda/aws//modules/deploy"
  version = "~> 6.0"

  depends_on = [module.TEST2_alias]

  alias_name     = module.TEST2_alias.lambda_alias_name
  function_name  = module.TEST2.lambda_function_name
  target_version = module.TEST2.lambda_function_version

  create_app = true
  app_name   = module.TEST2.lambda_function_name

  create_deployment_group = true
  deployment_group_name   = module.TEST2.lambda_function_name

  create_deployment          = true
  run_deployment             = true
  wait_deployment_completion = true

}

data "aws_sqs_queue" "TEST2" {
  name = "${local.name_prefix}-TEST2"
}

resource "aws_lambda_event_source_mapping" "TEST2" {
  event_source_arn = data.aws_sqs_queue.TEST2.arn
  function_name    = module.TEST2.lambda_function_name

  batch_size = 1
}
