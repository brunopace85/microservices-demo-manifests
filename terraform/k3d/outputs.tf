# Output para confirmar o nome e a context do kubeconfig
output "cluster_name" {
  value       = resource.k3d_cluster.example_cluster.host
  description = "Nome do cluster k3d criado"
}

output "argocd_port_forward" {
  description = "Comando para expor o painel do Argo CD localmente."
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "frontend_port_forward" {
  description = "Comando para expor o painel do Argo CD localmente."
  value       = "kubectl port-forward svc/frontend-external 5000:80 -n app-prod"
}
