terraform {
  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

  }
}

provider "yandex" {
  cloud_id   = var.cloud_id
  folder_id  = var.folder_id
  token = var.token
}

provider "flux" {}

provider "kubectl" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}