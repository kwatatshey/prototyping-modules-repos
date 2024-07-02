##########################################################################################
## HTTPS SVC - internet facing alb ingress
##########################################################################################

# resource "kubernetes_service_v1" "argogrpc" {
#   metadata {
#     name      = "argogrpc"
#     namespace = "argocd"

#     labels = {
#       "app.kubernetes.io/name" = "argocd-server"
#     }

#     annotations = {
#       "alb.ingress.kubernetes.io/backend-protocol-version" = "HTTP1"
#     }
#   }

#   spec {
#     selector = {
#       "app.kubernetes.io/name" = "argocd-server"
#     }

#     session_affinity = "None"

#     type = "NodePort"

#     port {
#       name        = "443"
#       port        = 443
#       protocol    = "TCP"
#       target_port = 8080
#     }
#   }
#   depends_on = [kubernetes_namespace.eks_namespaces]
# }


resource "kubectl_manifest" "argogrpc" {
  yaml_body  = <<YAML
apiVersion: v1
kind: Service
metadata:
  annotations:
    alb.ingress.kubernetes.io/backend-protocol-version: HTTP1
  labels:
    app.kubernetes.io/name: argocd-server
  name: argogrpc
  namespace: argocd
spec:
  ports:
  - name: "443"
    port: 443
    protocol: TCP
    targetPort: 8080
  selector:
    app.kubernetes.io/name: argocd-server
  sessionAffinity: None
  type: NodePort
YAML
  depends_on = [helm_release.argocd]
}

##########################################################################################
## HTTP SVC - internet facing alb ingress
##########################################################################################

# resource "kubernetes_service_v1" "argogrpc" {
#   metadata {
#     name      = "argogrpc"
#     namespace = "argocd"

#     labels = {
#       "app.kubernetes.io/name" = "argocd-server"
#     }

#     annotations = {
#       "alb.ingress.kubernetes.io/backend-protocol-version" = "HTTP1"
#     }
#   }

#   spec {
#     selector = {
#       "app.kubernetes.io/name" = "argocd-server"
#     }

#     session_affinity = "None"

#     type = "NodePort"

#     port {
#       name        = "80"
#       port        = 80
#       protocol    = "TCP"
#       target_port = 8080
#     }
#   }
#   depends_on = [kubernetes_namespace.eks_namespaces]
# }