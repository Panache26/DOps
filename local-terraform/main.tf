terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Підключаємо Terraform до вашого локального Docker Desktop Kubernetes
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

# 1. Автоматично створюємо ізольований простір імен для проєкту
resource "kubernetes_namespace" "finance_env" {
  metadata {
    name = "finance-local-env"
  }
}

# 2. Описуємо інфраструктуру застосунку (Deployment) через код
resource "kubernetes_deployment" "finance_app" {
  metadata {
    name      = "finance-backend"
    namespace = kubernetes_namespace.finance_env.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "finance"
      }
    }

    template {
      metadata {
        labels = {
          app = "finance"
        }
      }

      spec {
        container {
          image = "nginx:alpine"
          name  = "finance-backend-container"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# 3. Виводимо результат
output "namespace_created" {
  description = "Створений простір імен"
  value       = kubernetes_namespace.finance_env.metadata[0].name
}

output "deployment_name" {
  description = "Ім'я розгорнутого Deployment"
  value       = kubernetes_deployment.finance_app.metadata[0].name
}