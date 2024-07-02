# security

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
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | 5.1.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | Timeout for resource creation | `string` | `"15m"` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | Timeout for resource deletion | `string` | `"45m"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the security group | `string` | n/a | yes |
| <a name="input_egress_with_cidr_blocks"></a> [egress\_with\_cidr\_blocks](#input\_egress\_with\_cidr\_blocks) | List of egress rules with CIDR blocks | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    description = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_egress_with_ipv6_cidr_blocks"></a> [egress\_with\_ipv6\_cidr\_blocks](#input\_egress\_with\_ipv6\_cidr\_blocks) | List of egress rules with IPv6 CIDR blocks | <pre>list(object({<br>    from_port        = number<br>    to_port          = number<br>    protocol         = string<br>    description      = string<br>    ipv6_cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_enable_source_security_group_id"></a> [enable\_source\_security\_group\_id](#input\_enable\_source\_security\_group\_id) | Enable source security group ID for ALB security group ingress | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. | `string` | n/a | yes |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | List of ingress rules with CIDR blocks | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    description = string<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_with_ipv6_cidr_blocks"></a> [ingress\_with\_ipv6\_cidr\_blocks](#input\_ingress\_with\_ipv6\_cidr\_blocks) | List of ingress rules with IPv6 CIDR blocks | <pre>list(object({<br>    from_port        = number<br>    to_port          = number<br>    protocol         = string<br>    description      = string<br>    ipv6_cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_with_self"></a> [ingress\_with\_self](#input\_ingress\_with\_self) | List of ingress rules with self | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    description = string<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_with_source_security_group_id"></a> [ingress\_with\_source\_security\_group\_id](#input\_ingress\_with\_source\_security\_group\_id) | List of ingress rules with source security group ID | <pre>list(object({<br>    from_port                = number<br>    to_port                  = number<br>    protocol                 = string<br>    description              = string<br>    source_security_group_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the security group | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
