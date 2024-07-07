https://kyverno.io/docs/installation/methods/


The purpose of the helm_release resource named "kyverno_policies" is to manage the installation of the Kyverno Pod Security Standard policies chart.

Kyverno itself is a policy engine for Kubernetes, allowing you to enforce policies for resources in your cluster. The Kyverno Pod Security Standard policies, on the other hand, are a set of pre-defined policies that implement the Kubernetes Pod Security Standards. These policies help enhance the security posture of your Kubernetes cluster by enforcing best practices for pod security.

By deploying the Kyverno Pod Security Standard policies, you can ensure that your Kubernetes cluster follows industry-standard security practices related to pod security.

Here's why you might want to use a separate helm_release resource for the Kyverno Pod Security Standard policies:

Separation of Concerns: Keeping the installation of Kyverno and its policies separate allows for better organization and management of resources.
Modularity: You can choose to install Kyverno without the additional policies if you only need the policy engine functionality. Conversely, you can install the policies separately if you already have Kyverno installed and want to add additional policies later.
Flexibility: Managing the policies as a separate Helm release gives you more flexibility in terms of versioning, configuration, and lifecycle management.
Overall, using a separate helm_release resource for the Kyverno Pod Security Standard policies allows you to manage and deploy these policies independently from the main Kyverno application release.


https://kyverno.io/blog/2023/06/12/using-kyverno-with-pod-security-admission/

https://kyverno.io/blog/2024/04/26/kyverno-1.12-released/

https://www.datree.io/helm-chart/kyverno-crds-kyverno

https://kyverno.io/docs/installation/methods/


https://kyverno.io/policies/?policytypes=Karpenter<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.1 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.4.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.4.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0.3 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 >= 4.0.0 |
| <a name="provider_aws.virginia"></a> [aws.virginia](#provider\_aws.virginia) | >= 4.0.0 >= 4.0.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.4.1 >= 2.4.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 2.0.3 >= 2.0.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.10 >= 2.10 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | terraform-aws-modules/eks/aws//modules/karpenter | 20.11.1 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.argocd-app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress_gateway](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.karpenter_crd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.kyverno](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.kyverno_policies](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.sealed_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.spot_termination_handler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.argo_sgp](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argogrpc](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.ingress](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_inflate_deployment](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_node_class](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_on_demand_monitoring_pool](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_on_demand_pool](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_spot_pool](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_cluster_role.admin_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.developer_role_and_user](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.admin_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.developer_role_and_user_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map_v1_data.aws_auth_users](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [kubernetes_ingress_class.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_class) | resource |
| [kubernetes_secret.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret_v1.argo_config_repo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [kubernetes_service_account.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [null_resource.delete_argocd_pods](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.update_argocd_ingress](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecrpublic_authorization_token.token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecrpublic_authorization_token) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.amd_ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.arm_ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.github_ssh_private_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.gpu_ami_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ALB_SECURITY_GROUP_ID"></a> [ALB\_SECURITY\_GROUP\_ID](#input\_ALB\_SECURITY\_GROUP\_ID) | The ID of the ALB security group | `string` | n/a | yes |
| <a name="input_EKS_CLUSTER_SECURITY_GROUP_ID"></a> [EKS\_CLUSTER\_SECURITY\_GROUP\_ID](#input\_EKS\_CLUSTER\_SECURITY\_GROUP\_ID) | The ID of the EKS cluster security group | `string` | n/a | yes |
| <a name="input_admin_roles"></a> [admin\_roles](#input\_admin\_roles) | List of Kubernetes admin roles. | `list(string)` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application. | `string` | n/a | yes |
| <a name="input_argocd_ingress_alb_name"></a> [argocd\_ingress\_alb\_name](#input\_argocd\_ingress\_alb\_name) | The name of the ALB | `string` | n/a | yes |
| <a name="input_argocd_ingress_name"></a> [argocd\_ingress\_name](#input\_argocd\_ingress\_name) | ArgoCD ingress | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region. | `string` | `"us-east-1"` | no |
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | Amazon Resource Name (ARN) of the cluster. | `string` | n/a | yes |
| <a name="input_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#input\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster. | `string` | n/a | yes |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | Endpoint for your Kubernetes API server. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name. | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The Kubernetes version for the EKS cluster | `string` | n/a | yes |
| <a name="input_developer_roles"></a> [developer\_roles](#input\_developer\_roles) | List of Kubernetes developer roles. | `list(string)` | n/a | yes |
| <a name="input_developer_user_group"></a> [developer\_user\_group](#input\_developer\_user\_group) | Name of the kube group for developers. | `string` | n/a | yes |
| <a name="input_developer_users"></a> [developer\_users](#input\_developer\_users) | List of Kubernetes developers. | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. | `string` | n/a | yes |
| <a name="input_ingress_gateway_chart_name"></a> [ingress\_gateway\_chart\_name](#input\_ingress\_gateway\_chart\_name) | Ingress Gateway Helm chart name. | `string` | n/a | yes |
| <a name="input_ingress_gateway_chart_repo"></a> [ingress\_gateway\_chart\_repo](#input\_ingress\_gateway\_chart\_repo) | Ingress Gateway Helm repository name. | `string` | n/a | yes |
| <a name="input_ingress_gateway_chart_version"></a> [ingress\_gateway\_chart\_version](#input\_ingress\_gateway\_chart\_version) | Ingress Gateway Helm chart version. | `string` | n/a | yes |
| <a name="input_ingress_gateway_iam_role"></a> [ingress\_gateway\_iam\_role](#input\_ingress\_gateway\_iam\_role) | IAM Role Name associated with load-balancer service. | `string` | n/a | yes |
| <a name="input_ingress_gateway_name"></a> [ingress\_gateway\_name](#input\_ingress\_gateway\_name) | Load-balancer service name. | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC provider for the EKS cluster | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The IDs of the private subnets | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The IDs of the public subnets | `list(string)` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to be used on each infrastructure object Name created in AWS. | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The IDs of the security groups | `list(string)` | n/a | yes |
| <a name="input_spot_termination_handler_chart_name"></a> [spot\_termination\_handler\_chart\_name](#input\_spot\_termination\_handler\_chart\_name) | EKS Spot termination handler Helm chart name. | `string` | n/a | yes |
| <a name="input_spot_termination_handler_chart_namespace"></a> [spot\_termination\_handler\_chart\_namespace](#input\_spot\_termination\_handler\_chart\_namespace) | Kubernetes namespace to deploy EKS Spot termination handler Helm chart. | `string` | n/a | yes |
| <a name="input_spot_termination_handler_chart_repo"></a> [spot\_termination\_handler\_chart\_repo](#input\_spot\_termination\_handler\_chart\_repo) | EKS Spot termination handler Helm repository name. | `string` | n/a | yes |
| <a name="input_spot_termination_handler_chart_version"></a> [spot\_termination\_handler\_chart\_version](#input\_spot\_termination\_handler\_chart\_version) | EKS Spot termination handler Helm chart version. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
