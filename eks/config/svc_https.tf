# ##########################################################################################
# ## HTTPS SVC - internet facing alb ingress
# ##########################################################################################

# resource "kubectl_manifest" "argogrpc" {
#   yaml_body  = <<YAML
# apiVersion: v1
# kind: Service
# metadata:
#   annotations:
#     alb.ingress.kubernetes.io/backend-protocol-version: HTTP1
#   labels:
#     app.kubernetes.io/name: argocd-server
#   name: argogrpc
#   namespace: argocd
# spec:
#   ports:
#   - name: "443"
#     port: 443
#     protocol: TCP
#     targetPort: 8080
#   selector:
#     app.kubernetes.io/name: argocd-server
#   sessionAffinity: None
#   type: NodePort
# YAML
#   depends_on = [helm_release.argocd]
# }