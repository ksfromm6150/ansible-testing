data "aws_iam_role" "test" {
  name = "${local.name_prefix}-collectrenewals-${local.region}"
}

module "test" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${local.name_prefix}-test"

  package_type   = "Image"
  image_uri      = var.image_test
  create_package = false

  lambda_role     = data.aws_iam_role.test.arn
  create_role     = false
  attach_policies = false

  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  image_config_command = ["ansible-testing.test::ordermanagement.shared.ansible-testing.test.Function::FunctionHandler"]

  publish = true
}

module "test_alias" {
  source  = "terraform-aws-modules/lambda/aws//modules/alias"
  version = "~> 6.0"

  depends_on = [module.test]

  name             = "current"
  function_name    = module.test.lambda_function_name
  function_version = module.test.lambda_function_version
}

module "test_deploy" {
  source  = "terraform-aws-modules/lambda/aws//modules/deploy"
  version = "~> 6.0"

  depends_on = [module.test_alias]

  alias_name     = module.test_alias.lambda_alias_name
  function_name  = module.test.lambda_function_name
  target_version = module.test.lambda_function_version

  create_app = true
  app_name   = module.test.lambda_function_name

  create_deployment_group = true
  deployment_group_name   = module.test.lambda_function_name

  create_deployment          = true
  run_deployment             = true
  wait_deployment_completion = true

}

data "aws_sqs_queue" "test" {
  name = "${local.name_prefix}-test"
}

resource "aws_lambda_event_source_mapping" "test" {
  event_source_arn = data.aws_sqs_queue.test.arn
  function_name    = module.test.lambda_function_name

  batch_size = 1
}
