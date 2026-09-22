# =======================================================
# PASSO 1: Criação do Cluster Local k3d
# =======================================================
resource "null_resource" "k3d_cluster" {
  provisioner "local-exec" {
    command = "k3d cluster create devops-tcc --agents 2 --wait"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "k3d cluster delete devops-tcc"
  }
}

# =======================================================
# CONFIGURAÇÃO DOS PROVEDORES (Kubernetes / Helm)
# =======================================================
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-devops-tcc"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "k3d-devops-tcc"
  }
}

# =======================================================
# PASSO 2: Recursos Internos do Cluster (Ex: Namespace ArgoCD)
# =======================================================
# 1. Cria o Namespace 'argocd' usando a API v1 recomendada
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }

  depends_on = [null_resource.k3d_cluster]
}

# 2. Instala o ArgoCD via Helm Chart automaticamente
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace_v1.argocd.metadata[0].name

  depends_on = [kubernetes_namespace_v1.argocd]
}
