terraform {
  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
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

provider "kubectl" {
  config_path = "/tmp/yc-terraform-k8s"
}

provider "kubernetes" {
  config_path = "/tmp/yc-terraform-k8s"
}
