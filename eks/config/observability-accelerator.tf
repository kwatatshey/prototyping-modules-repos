# module "eks_monitoring" {
#   source = "github.com/aws-observability/terraform-aws-observability-accelerator//modules/eks-monitoring"
#   # eks_cluster_id = "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.cluster_name}"
#   eks_cluster_id = var.cluster_name

#   # deploys AWS Distro for OpenTelemetry operator into the cluster
#   enable_amazon_eks_adot = true

#   # reusing existing certificate manager? defaults to true
#   enable_cert_manager = true

#   # enable EKS API server monitoring
#   enable_apiserver_monitoring = true

#   # deploys external-secrets in to the cluster
#   enable_external_secrets = true
#   grafana_api_key         = var.grafana_api_key
#   target_secret_name      = "grafana-admin-credentials"
#   target_secret_namespace = "grafana-operator"
#   # grafana_url             = "https://${data.aws_grafana_workspace.this.endpoint}"
#   grafana_url = "https://${module.managed_grafana.workspace_endpoint}"

#   # control the publishing of dashboards by specifying the boolean value for the variable 'enable_dashboards', default is 'true'
#   enable_dashboards = var.enable_dashboards

#   # creates a new Amazon Managed Prometheus workspace, defaults to true
#   enable_managed_prometheus       = local.create_new_workspace
#   managed_prometheus_workspace_id = var.managed_prometheus_workspace_id

#   # sets up the Amazon Managed Prometheus alert manager at the workspace level
#   enable_alertmanager = true

#   # optional, defaults to 60s interval and 15s timeout
#   prometheus_config = {
#     global_scrape_interval = "60s"
#     global_scrape_timeout  = "15s"
#   }

#   enable_logs = true

#   tags       = local.tags
#   depends_on = [module.managed_grafana]
# }


# module "managed_grafana" {
#   source  = "terraform-aws-modules/managed-service-grafana/aws"
#   version = "2.1.1"

#   name                      = local.name
#   associate_license         = false
#   description               = local.description
#   account_access_type       = "CURRENT_ACCOUNT"
#   authentication_providers  = ["AWS_SSO"]
#   permission_type           = "SERVICE_MANAGED"
#   data_sources              = ["CLOUDWATCH", "PROMETHEUS", "XRAY", "ATHENA"]
#   notification_destinations = ["SNS"]
#   stack_set_name            = local.name

#   configuration = jsonencode({
#     unifiedAlerting = {
#       enabled = true
#     }
#   })

#   grafana_version = "10.4"


#   # Workspace IAM role
#   create_iam_role = true
#   iam_role_name   = local.name
#   # use_iam_role_name_prefix       = true
#   iam_role_description           = local.description
#   iam_role_path                  = "/grafana/"
#   iam_role_force_detach_policies = true
#   iam_role_max_session_duration  = 7200
#   iam_role_tags                  = local.tags

#   tags       = local.tags
#   depends_on = [helm_release.karpenter]
# }