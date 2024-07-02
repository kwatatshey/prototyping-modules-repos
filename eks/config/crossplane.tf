# resource "helm_release" "uxp" {
#   name             = "uxp"
#   namespace        = "upbound-system"
#   repository       = "https://charts.upbound.io/stable"
#   chart            = "universal-crossplane"
#   create_namespace = true
#   version          = "1.16.0-up.1"

#   # set {
#   #   name  = "image.repository"
#   #   value = "709825985650.dkr.ecr.us-east-1.amazonaws.com/upbound/crossplane"
#   # }

#   # set {
#   #   name  = "agent.image.repository"
#   #   value = "709825985650.dkr.ecr.us-east-1.amazonaws.com/upbound/upbound-agent"
#   # }

#   # set {
#   #   name  = "bootstrapper.image.repository"
#   #   value = "709825985650.dkr.ecr.us-east-1.amazonaws.com/upbound/uxp-bootstrapper"
#   # }

#   set {
#     name  = "image.pullPolicy"
#     value = "Always"
#   }

#   # set {
#   #   name  = "xgql.image.repository"
#   #   value = "709825985650.dkr.ecr.us-east-1.amazonaws.com/upbound/xgql"
#   # }
#   set {
#     name  = "replicas"
#     value = "2"
#   }

#   set {
#     name  = "billing.awsMarketplace.enabled"
#     value = "true"
#   }

#   set {
#     name  = "billing.awsMarketplace.iamRoleARN"
#     value = module.irsa.iam_role_arn
#   }
#   # values = [
#   #   file("${path.module}/settings.yaml")
#   # ]
# }


# module "irsa" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version = "5.33.0"

#   role_name                              = "${var.resource_prefix}-${var.environment}-${var.app_name}-crossplane"
#   attach_load_balancer_controller_policy = true

#   role_policy_arns = {
#     additional_policy = module.additional_policy.arn
#   }

#   oidc_providers = {
#     ex = {
#       provider_arn               = var.oidc_provider_arn
#       namespace_service_accounts = ["upbound-system:upbound-bootstrapper"]
#     }
#   }
# }


# module "additional_policy" {
#   source        = "terraform-aws-modules/iam/aws//modules/iam-policy"
#   version       = "5.39.0"
#   create_policy = true
#   name          = "${var.resource_prefix}-${var.environment}-${var.app_name}-custom-policy"
#   path          = "/"
#   description   = "Additional policy for eks node group"
#   policy        = data.aws_iam_policy_document.additional_policy.json

#   tags = {
#     PolicyDescription = "Policy created using example from data source"
#   }
# }

# data "aws_iam_policy_document" "additional_policy" {
#   statement {
#     actions = [
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:GetRepositoryPolicy",
#       "ecr:DescribeRepositories",
#       "ecr:ListImages",
#       "ecr:DescribeImages",
#       "ecr:BatchGetImage",
#       "ecr:GetLifecyclePolicy",
#       "ecr:GetLifecyclePolicyPreview",
#       "ecr:ListTagsForResource",
#       "ecr:DescribeImageScanFindings",
#       "ec2:*",
#       "elasticfilesystem:*",
#       "logs:*",
#       "iam:PassRole",
#       "logs:*",
#       "events:*",
#       "eks:*"
#     ]
#     effect    = "Allow"
#     resources = ["*"]
#   }
# }