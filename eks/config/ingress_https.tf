# # ##########################################################################################
# # ## HTTPS - internet facing alb ingress
# # ##########################################################################################

# # Create the service account in specified namespaces
# resource "kubernetes_service_account" "load_balancer_controller" {
#   metadata {
#     name      = var.ingress_gateway_name
#     namespace = "argocd"

#     labels = {
#       "app.kubernetes.io/component" = "controller"
#       "app.kubernetes.io/name"      = var.ingress_gateway_name
#     }
#     annotations = {
#       "eks.amazonaws.com/role-arn" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.ingress_gateway_iam_role}"
#     }

#   }
#   depends_on = [kubernetes_config_map_v1_data.aws_auth_users, helm_release.argocd]
# }

# # Create the service account token secret in specified namespaces
# resource "kubernetes_secret" "load_balancer_controller" {
#   type                           = "kubernetes.io/service-account-token"
#   wait_for_service_account_token = true

#   metadata {
#     namespace     = "argocd"
#     generate_name = "${kubernetes_service_account.load_balancer_controller.metadata[0].name}-token"
#     annotations = {
#       "kubernetes.io/service-account.name" = kubernetes_service_account.load_balancer_controller.metadata[0].name
#     }
#   }
#   depends_on = [kubernetes_service_account.load_balancer_controller]
# }

# resource "helm_release" "ingress_gateway" {
#   name       = var.ingress_gateway_chart_name
#   chart      = var.ingress_gateway_chart_name
#   repository = var.ingress_gateway_chart_repo
#   version    = var.ingress_gateway_chart_version
#   namespace  = "argocd"
#   set {
#     name  = "clusterName"
#     value = var.cluster_name
#   }
#   set {
#     name  = "serviceAccount.name"
#     value = kubernetes_service_account.load_balancer_controller.metadata[0].name
#   }

#   set {
#     name  = "region"
#     value = var.aws_region
#   }

#   set {
#     name  = "vpcId"
#     value = var.vpc_id
#   }
#   # set {
#   #   name  = "replicas"
#   #   value = 3
#   # }
#   set {
#     name  = "serviceAccount.create"
#     value = "false"
#   }
#   depends_on = [kubernetes_service_account.load_balancer_controller]
# }

# resource "kubernetes_ingress_class" "argocd" {
#   metadata {
#     name = "argocd"
#   }

#   spec {
#     controller = "ingress.k8s.aws/alb"
#   }
#   depends_on = [helm_release.argocd]
# }


# resource "kubectl_manifest" "ingress" {
#   yaml_body = <<YAML
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: ${var.argocd_ingress_name}
#   namespace: argocd
#   annotations:
#     alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}, {"HTTP": 8080}, {"HTTPS": 8443}]'
#     alb.ingress.kubernetes.io/success-codes: 200-399
#     alb.ingress.kubernetes.io/target-group-attributes: stickiness.enabled=true,stickiness.lb_cookie.duration_seconds=60
#     alb.ingress.kubernetes.io/load-balancer-attributes: idle_timeout.timeout_seconds=600,access_logs.s3.enabled=true,access_logs.s3.bucket=${module.s3_bucket.s3_bucket_id},access_logs.s3.prefix=argocd
#     alb.ingress.kubernetes.io/load-balancer-name: ${var.argocd_ingress_alb_name}
#     alb.ingress.kubernetes.io/scheme: internet-facing
#     alb.ingress.kubernetes.io/target-type: ip
#     alb.ingress.kubernetes.io/subnets: ${join(", ", var.public_subnets)}
#     alb.ingress.kubernetes.io/certificate-arn: ${aws_acm_certificate.eks_domain_cert.arn}
#     alb.ingress.kubernetes.io/security-groups: ${join(", ", var.security_groups)}
#     alb.ingress.kubernetes.io/backend-protocol: HTTPS
#     # alb.ingress.kubernetes.io/backend-protocol: HTTP
#     alb.ingress.kubernetes.io/conditions.argogrpc: |
#       [{"field":"http-header","httpHeaderConfig":{"httpHeaderName": "Content-Type", "values":["application/grpc"]}}]
#     # alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
# spec:
#   ingressClassName: "${kubernetes_ingress_class.argocd.metadata[0].name}"
#   rules:
#   - host: "argocd.${var.environment}.${var.dns_base_domain}"
#     http:
#       paths:
#       - path: /
#         backend:
#           service:
#             name: argogrpc
#             port:
#               number: 443
#         pathType: Prefix
#       - path: /
#         backend:
#           service:
#             name: argocd-server
#             port:
#               number: 443
#         pathType: Prefix
#   YAML
#   depends_on = [
#     kubernetes_service_account.load_balancer_controller,
#     kubernetes_secret.load_balancer_controller,
#     helm_release.ingress_gateway,
#     kubectl_manifest.argogrpc,
#   ]
# }

# module "s3_bucket" {
#   source                                     = "terraform-aws-modules/s3-bucket/aws"
#   create_bucket                              = true
#   version                                    = "4.1.2"
#   bucket                                     = "argocd-${var.resource_prefix}-${var.environment}-${var.app_name}-elb-access-logs"
#   acl                                        = "private"
#   force_destroy                              = true
#   control_object_ownership                   = true
#   object_ownership                           = "ObjectWriter"
#   access_log_delivery_policy_source_accounts = [data.aws_caller_identity.current.account_id]
#   policy                                     = data.aws_iam_policy_document.bucket_policy.json
#   attach_policy                              = true

#   versioning = {
#     enabled = true
#   }
# }

# data "aws_iam_policy_document" "bucket_policy" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::127311923021:root"]
#     }

#     actions = [
#       "s3:PutObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       module.s3_bucket.s3_bucket_arn,
#       "${module.s3_bucket.s3_bucket_arn}/*",
#     ]
#   }
# }