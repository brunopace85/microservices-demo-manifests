variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "eks-web-cluster"
}

variable "github_repo_url" {
  description = "URL HTTPS do repositório Git"
  type        = string
  default     = "https://github.com/brunopace85/microservices-demo-manifests.git"
}

variable "github_repo_target_revision" {
  description = "Branch ou Tag do repositório"
  type        = string
  default     = "main" # ou "main"
}

variable "github_repo_path" {
  description = "Caminho da pasta dentro do repositório onde estão os arquivos YAML"
  type        = string
  default     = "." # use "k8s" ou "manifests" se os YAMLs estiverem em uma subpasta
}

variable "app_label_selector" {
  description = "Label 'app' que os Pods nos seus manifestos utilizam"
  type        = string
  default     = "frontend"
}

variable "app_target_port" {
  description = "Porta em que a aplicação dentro do Pod escuta"
  type        = number
  default     = 8080
}