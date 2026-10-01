output "cluster_endpoint" {
  description = "Endpoint do API Server do EKS."
  value       = module.eks.cluster_endpoint
}

output "configure_kubectl" {
  description = "Comando para configurar a autenticação local do kubectl."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "argocd_initial_admin_password" {
  description = "Comando para obter a senha inicial de administrador do Argo CD."
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo"
}

output "argocd_port_forward" {
  description = "Comando para expor o painel do Argo CD localmente."
  value       = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
}

# Output para exibir a URL pública do Load Balancer no terminal após o apply
output "frontend_url_dev" {
  description = "URL pública de acesso à Online Boutique"
  value       = kubernetes_service.frontend_lb_dev.status[0].load_balancer[0].ingress[0].hostname
}

output "frontend_url_prod" {
  description = "URL pública de acesso à Online Boutique"
  value       = kubernetes_service.frontend_lb_prod.status[0].load_balancer[0].ingress[0].hostname
}
