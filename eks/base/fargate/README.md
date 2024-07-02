# fargate

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.41.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fargate_profile"></a> [fargate\_profile](#module\_fargate\_profile) | terraform-aws-modules/eks/aws//modules/fargate-profile | 20.8.5 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_policies"></a> [additional\_policies](#input\_additional\_policies) | Additional policies to be added to the IAM role. | `map(string)` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. | `string` | n/a | yes |
| <a name="input_fargate_profile_name"></a> [fargate\_profile\_name](#input\_fargate\_profile\_name) | Name of the Fargate Profile. | `string` | n/a | yes |
| <a name="input_fargate_profile_namespace"></a> [fargate\_profile\_namespace](#input\_fargate\_profile\_namespace) | Namespace to be used by the Fargate Profile. | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to be used on each infrastructure object Name created in AWS. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs to launch Fargate Profiles in. | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
