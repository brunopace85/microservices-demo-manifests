# Criação da infraestrutura do projeto

Essa solução de infraestrutura para demonstração do projeto se baseia em um cluster K3D hosteado localmente.

O Terraform cria o cluster local, instala o argocd no cluster e cria as duas aplicações (ambientes prod/dev) no argocd.

## Requisitos para execução

Terraform>=1.3.0 instalado
Kubectl instalado
K3D instalado

## Deploy da infraestrutura

terraform init
terraform plan
terraform apply

## Configuração do ambiente pós deploy da infra

Após aplicar o terraform, será mostrado no terminal os outputs configurados ("outputs.tf") informando:

- Comando k3d para configuração do kubectl
- Comando para encaminhamento de portas dos services do argocd e da aplicação principal
- Comando para revelar senha do argocd


## Verifique o ArgoCD

kubectl get pods -n argocd

Acesse a interface do argocd pela porta 8080 do localhost após fazer o encaminhamneto, e acesse usando usuário "admin" e senha provida pelo comando do output
