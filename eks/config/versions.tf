terraform {
  required_version = "1.8.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }

    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.3"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
  }
}


# get EKS authentication for being able to manage k8s objects from terraform
provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    # args        = ["eks", "get-token", "--cluster-name", "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.cluster_name}"]
    args    = ["eks", "get-token", "--cluster-name", var.cluster_name, "--output", "json"]
    command = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      # args        = ["eks", "get-token", "--cluster-name", "${var.resource_prefix}-${var.environment}-${var.app_name}-${var.cluster_name}"]
      args    = ["eks", "get-token", "--cluster-name", var.cluster_name, "--output", "json"]
      command = "aws"
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--output", "json"]
    command     = "aws"
  }
}


provider "aws" {
  region = local.region
}
