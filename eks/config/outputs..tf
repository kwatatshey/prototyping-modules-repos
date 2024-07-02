# output "managed_prometheus_workspace_region" {
#   description = "AWS Region"
#   value       = module.eks_monitoring.managed_prometheus_workspace_region
# }

# output "managed_prometheus_workspace_endpoint" {
#   description = "Amazon Managed Prometheus workspace endpoint"
#   value       = module.eks_monitoring.managed_prometheus_workspace_endpoint
# }

# output "managed_prometheus_workspace_id" {
#   description = "Amazon Managed Prometheus workspace ID"
#   value       = module.eks_monitoring.managed_prometheus_workspace_id
# }

# output "eks_cluster_version" {
#   description = "EKS Cluster version"
#   value       = module.eks_monitoring.eks_cluster_version
# }

# output "eks_cluster_id" {
#   description = "EKS Cluster Id"
#   value       = module.eks_monitoring.eks_cluster_id
# }




#-----fin

# output "grafana_workspace_endpoint" {
#   description = "Amazon Managed Grafana Workspace endpoint"
#   value       = "https://${module.managed_grafana.workspace_endpoint}"
# }



# output "grafana_workspace_id" {
#   description = "Amazon Managed Grafana Workspace ID"
#   value       = module.managed_grafana.workspace_id
# }

# output "grafana_workspace_iam_role_arn" {
#   description = "Amazon Managed Grafana Workspace's IAM Role ARN"
#   value       = module.managed_grafana.workspace_iam_role_arn
# }