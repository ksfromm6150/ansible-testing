data "aws_iam_role" "function3" {
  name = "${local.name_prefix}-function3-${local.region}"
}

module "function3" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${local.name_prefix}-function3"

  package_type   = "Image"
  image_uri      = var.image_function3
  create_package = false

  lambda_role     = data.aws_iam_role.function3.arn
  create_role     = false
  attach_policies = false

  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  image_config_command = ["ansible-testing.function3::ordermanagement.shared.ansible-testing.function3.Function::FunctionHandler"]

  publish = true
}

module "function3_alias" {
  source  = "terraform-aws-modules/lambda/aws//modules/alias"
  version = "~> 6.0"

  depends_on = [module.function3]

  name             = "current"
  function_name    = module.function3.lambda_function_name
  function_version = module.function3.lambda_function_version
}

module "function3_deploy" {
  source  = "terraform-aws-modules/lambda/aws//modules/deploy"
  version = "~> 6.0"

  depends_on = [module.function3_alias]

  alias_name     = module.function3_alias.lambda_alias_name
  function_name  = module.function3.lambda_function_name
  target_version = module.function3.lambda_function_version

  create_app = true
  app_name   = module.function3.lambda_function_name

  create_deployment_group = true
  deployment_group_name   = module.function3.lambda_function_name

  create_deployment          = true
  run_deployment             = true
  wait_deployment_completion = true

}

data "aws_sqs_queue" "function3" {
  name = "${local.name_prefix}-function3"
}

resource "aws_lambda_event_source_mapping" "function3" {
  event_source_arn = data.aws_sqs_queue.function3.arn
  function_name    = module.function3.lambda_function_name

  batch_size = 1
}
