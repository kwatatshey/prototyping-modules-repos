# vpc

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.41.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.41.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.8.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_gw_elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/5.41.0/docs/resources/eip) | resource |
| [aws_availability_zones.available_azs](https://registry.terraform.io/providers/hashicorp/aws/5.41.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application. | `string` | n/a | yes |
| <a name="input_cluster_azs"></a> [cluster\_azs](#input\_cluster\_azs) | List of Availability Zones to be used in EKS | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. | `string` | n/a | yes |
| <a name="input_main_network_block"></a> [main\_network\_block](#input\_main\_network\_block) | Base CIDR block to be used in our VPC. | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to be used on each infrastructure object Name created in AWS. | `string` | n/a | yes |
| <a name="input_subnet_prefix_extension"></a> [subnet\_prefix\_extension](#input\_subnet\_prefix\_extension) | CIDR block bits extension to calculate CIDR blocks of each subnetwork. | `number` | n/a | yes |
| <a name="input_zone_offset"></a> [zone\_offset](#input\_zone\_offset) | CIDR block bits extension offset to calculate Public subnets, avoiding collisions with Private subnets. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
