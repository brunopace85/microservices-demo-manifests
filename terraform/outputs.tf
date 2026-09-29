output "fixed_public_ip" {
  description = "IP Público Fixo para acessar a aplicação web"
  value       = aws_eip.fixed_ip.public_ip
}

output "argocd_initial_admin_password_command" {
  description = "Comando para recuperar a senha inicial do admin do ArgoCD"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}