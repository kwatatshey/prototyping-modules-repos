# get (externally configured) DNS Zone
# ATTENTION: if you don't have a Route53 Zone already, replace this data by a new resource
# data "aws_route53_zone" "base_domain" {
#   name = var.dns_base_domain
# }

# create AWS-issued SSL certificate
# resource "aws_acm_certificate" "eks_domain_cert" {
#   domain_name               = var.dns_base_domain
#   subject_alternative_names = ["*.${var.dns_base_domain}"]
#   validation_method         = "DNS"

#   tags = {
#     Name = var.dns_base_domain
#   }
# }
# resource "aws_route53_record" "eks_domain_cert_validation_dns" {
#   for_each = {
#     for dvo in aws_acm_certificate.eks_domain_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.base_domain.zone_id
# }
# resource "aws_acm_certificate_validation" "eks_domain_cert_validation" {
#   certificate_arn         = aws_acm_certificate.eks_domain_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.eks_domain_cert_validation_dns : record.fqdn]
# }

# resource "aws_route53_record" "argocd_dns" {
#   zone_id = data.aws_route53_zone.base_domain.zone_id
#   name    = "argocd"
#   type    = "A"
#   alias {
#     name                   = kubernetes_ingress_v1.argocd_ingress.status.0.load_balancer.0.ingress.0.hostname
#     zone_id                = data.aws_alb.argocd_alb.zone_id
#     evaluate_target_health = true
#   }
#   depends_on = [kubernetes_ingress_v1.argocd_ingress]
# }



# resource "aws_route53_record" "cname" {
#   zone_id = data.aws_route53_zone.base_domain.zone_id
#   name    = var.argocd_subdomain
#   type    = "CNAME"
#   ttl     = 300
#   records = [data.aws_lb.my_lb.dns_name]
# }

# data "aws_lb" "my_lb" {
#   name       = var.argocd_ingress_alb_name
#   depends_on = [kubectl_manifest.ingress]
# }


# resource "null_resource" "rollout_restart" {
#   provisioner "local-exec" {
#     command     = <<-EOT
#       aws eks update-kubeconfig --region ${local.aws_region} --name ${var.cluster_name} && \
#       kubectl config use-context ${var.cluster_arn} && \
#       kubectl rollout restart deployment argocd-dex-server -n argocd && \
#       kubectl rollout restart deployment argocd-server -n argocd && \
#       kubectl rollout restart deployment argocd-repo-server -n argocd
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }

#   depends_on = [aws_route53_record.cname]
# }






