locals {
  user_access_entries = { for user in var.developer_users : user => {
    kubernetes_groups = ["${var.resource_prefix}-${var.environment}-${var.app_name}-${var.developer_user_group}"]
    principal_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}"
    policy_associations = {
      user = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
        access_scope = {
          namespaces = ["kube-system"]
          type       = "namespace"
        }
      }
    }
  } if user == "Terraform" } # This line filters the users

  role_access_entries = { for role in var.developer_roles : role => {
    kubernetes_groups = ["${var.resource_prefix}-${var.environment}-${var.app_name}-${var.developer_user_group}"]
    principal_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${role}"
    policy_associations = {
      role = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
        access_scope = {
          namespaces = ["kube-system"]
          type       = "namespace"
        }
      }
    }
  } }
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN