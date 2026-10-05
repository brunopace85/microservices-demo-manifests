# Output para confirmar o nome e a context do kubeconfig
output "cluster_name" {
  value       = resource.k3d_cluster.example_cluster.host
  description = "Nome do cluster k3d criado"
}

output "argocd_port_forward" {
  description = "Comando para expor o painel do Argo CD localmente."
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

output "frontend_port_forward_prod" {
  description = "Comando para expor o painel do Argo CD localmente. (PROD)"
  value       = "kubectl port-forward svc/frontend-external 5000:80 -n app-prod"
}

output "frontend_port_forward_dev" {
  description = "Comando para expor o painel do Argo CD localmente. (DEV)"
  value       = "kubectl port-forward svc/frontend-external 5001:80 -n app-dev"
}

output "kube_prometheus_grafana" {
  description = "Port forward do grafana"
  value       = "kubectl port-forward svc/kube-prometheus-stack-grafana 6000:80 -n monitoring"
}

output "argocd_password_cmd" {
    description = "Comando para extrair senha do argocd"
    value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}

output "kubectl_config" {
    description = "Comando k3d para configuração do kubectl"
    value       = "k3d kubeconfig merge example --kubeconfig-merge-default"
}