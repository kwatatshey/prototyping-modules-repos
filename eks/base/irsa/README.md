# irsa

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.65.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.65.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_additional_policy"></a> [additional\_policy](#module\_additional\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.39.0 |
| <a name="module_eks_common_iam"></a> [eks\_common\_iam](#module\_eks\_common\_iam) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.39.0 |
| <a name="module_eks_external_dns_iam"></a> [eks\_external\_dns\_iam](#module\_eks\_external\_dns\_iam) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.33.0 |
| <a name="module_eks_ingress_iam"></a> [eks\_ingress\_iam](#module\_eks\_ingress\_iam) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.33.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.additional_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application. | `string` | n/a | yes |
| <a name="input_autoscaller_cluster_name"></a> [autoscaller\_cluster\_name](#input\_autoscaller\_cluster\_name) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `any` | n/a | yes |
| <a name="input_irsa-role-name"></a> [irsa-role-name](#input\_irsa-role-name) | n/a | `any` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | n/a | `any` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix to be used on all resources | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_policy_arn"></a> [additional\_policy\_arn](#output\_additional\_policy\_arn) | n/a |
| <a name="output_eks_addons_service_account_role_arn"></a> [eks\_addons\_service\_account\_role\_arn](#output\_eks\_addons\_service\_account\_role\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
