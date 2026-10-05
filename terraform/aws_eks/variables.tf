variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Região da AWS onde os recursos serão criados."
}

variable "cluster_name" {
  type        = string
  default     = "eks-microservices-demo"
  description = "Nome do cluster EKS."
}

variable "git_repo_url" {
  type        = string
  default     = "https://github.com/brunopace85/microservices-demo-manifests.git"
  description = "URL do seu repositório GitHub contendo os manifests separadamente por serviço."
}

variable "git_repo_prod_path" {
  type        = string
  default     = "prod"
  description = "Caminho (path) dentro do repositório onde os manifests estão salvos."
}

variable "git_repo_dev_path" {
  type        = string
  default     = "dev"
  description = "Caminho (path) dentro do repositório onde os manifests estão salvos."
}

variable "git_repo_revision" {
  type        = string
  default     = "HEAD"
  description = "Branch, tag ou commit a ser monitorado pelo Argo CD (ex: HEAD, main)."
}