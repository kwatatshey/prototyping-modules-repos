locals {
  admin_role_map_roles = [
    for admin_role in var.admin_roles : {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${admin_role}"
      username = admin_role
      groups   = ["system:masters"]
    }
  ]

  cross_account_admin_role_map_roles = [
    for cross_account_admin_role in var.cross_account_admin_roles : {
      rolearn  = cross_account_admin_role
      username = cross_account_admin_role
      groups   = ["system:masters"]
    }
  ]

  developer_role_map_roles = [
    for developer_role in var.developer_roles : {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${developer_role}"
      username = developer_role
      groups   = ["${var.resource_prefix}-${var.environment}-${var.app_name}-${var.developer_user_group}"]
    }
  ]

  karpenter_role_map_role = [{
    rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${module.karpenter.node_iam_role_arn}"
    username = "system:node:{{EC2PrivateDNSName}}"
    groups   = ["system:bootstrappers", "system:nodes"]
  }]

  developer_user_map_users = [
    for developer_user in var.developer_users : {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${developer_user}"
      username = developer_user
      groups   = ["${var.resource_prefix}-${var.environment}-${var.app_name}-${var.developer_user_group}"]
    }
  ]
}

resource "time_sleep" "wait" {
  create_duration = "180s"
  triggers = {
    cluster_endpoint = var.cluster_endpoint
  }
}

resource "kubernetes_config_map_v1_data" "aws_auth_users" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode(local.developer_user_map_users)
    mapRoles = yamlencode(concat(
      local.admin_role_map_roles,
      local.cross_account_admin_role_map_roles,
      local.developer_role_map_roles,
      local.karpenter_role_map_role
    ))
  }

  force = true

  depends_on = [time_sleep.wait]
}

resource "kubernetes_cluster_role" "admin_role" {
  metadata {
    name = "${var.resource_prefix}-${var.environment}-${var.app_name}-admin"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "admin_role_binding" {
  metadata {
    name = "${var.resource_prefix}-${var.environment}-${var.app_name}-admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.admin_role.metadata[0].name
  }

  dynamic "subject" {
    for_each = local.admin_role_map_roles

    content {
      name      = subject.value.username
      kind      = "User"
      api_group = "rbac.authorization.k8s.io"
    }
  }
}

resource "kubernetes_cluster_role" "developer_role_and_user" {
  metadata {
    name = "${var.resource_prefix}-${var.environment}-${var.app_name}-developers"
  }

  rule {
    api_groups = ["*"]
    resources  = ["pods", "pods/log", "deployments", "ingresses", "services"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["*"]
    resources  = ["pods/exec"]
    verbs      = ["create"]
  }

  rule {
    api_groups = ["*"]
    resources  = ["pods/portforward"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "developer_role_and_user_binding" {
  metadata {
    name = "${var.resource_prefix}-${var.environment}-${var.app_name}-developers-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.developer_role_and_user.metadata[0].name
  }

  dynamic "subject" {
    for_each = toset(concat(var.developer_users, var.developer_roles))

    content {
      name      = subject.value
      kind      = "User"
      api_group = "rbac.authorization.k8s.io"
    }
  }
}
