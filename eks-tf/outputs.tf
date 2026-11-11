output "cluster_name" {
  description = "Ім'я створеного кластера"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Ендпоінт для підключення kubectl"
  value       = module.eks.cluster_endpoint
}