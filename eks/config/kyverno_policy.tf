resource "helm_release" "kyverno" {
  depends_on       = [helm_release.karpenter]
  name             = "kyverno"
  repository       = "https://kyverno.github.io/kyverno/"
  chart            = "kyverno"
  create_namespace = true
  namespace        = "kyverno"

  # High Availability (https://kyverno.io/docs/installation/methods/)
  set {
    name  = "admissionController.replicas"
    value = "3"
  }

  set {
    name  = "backgroundController.replicas"
    value = "2"
  }

  set {
    name  = "cleanupController.replicas"
    value = "2"
  }

  set {
    name  = "reportsController.replicas"
    value = "2"
  }


  #   values = yamldecode(file("${path.module}/values/kyverno-policy.yaml"))


  // Omitting namespace to install Kyverno cluster-wide
  // namespace = "kyverno"
}

resource "helm_release" "kyverno_policies" {
  depends_on = [helm_release.kyverno]
  name       = "kyverno-policies"
  repository = "https://kyverno.github.io/kyverno/"
  chart      = "kyverno-policies"
  namespace  = "kyverno" # Make sure to deploy in the same namespace as Kyverno

  # Add any additional attributes or values here if needed
}


