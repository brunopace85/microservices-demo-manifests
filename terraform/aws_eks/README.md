# Criação da infraestrutura do projeto

Como essa solução funciona:
Deploy da Infraestrutura: O Terraform provisiona a VPC, o EKS e o controlador de Load Balancers da AWS.

Instalação do ArgoCD: O Helm instala o ArgoCD no namespace argocd.

Mapeamento GitOps: O recurso kubectl_manifest.argocd_application instrui o ArgoCD a sincronizar continuamente todos os manifestos .yaml localizados no caminho var.github_repo_path do seu repositório no GitHub.

## Requisitos para execução

Terraform>=1.3.0 instalado
Kubectl instalado
AWS CLI instalado e configuradas as credenciais

## Deploy da infraestrutura

terraform init
terraform plan
terraform apply

## Configuração do ambiente pós deploy da infra

Após aplicar o terraform, será mostrado no terminal os outputs configurados ("outputs.tf") informando:

- Endpoint do API Server do EKS.


## Verifique o ArgoCD
kubectl get pods -n argocd

## Verifique sua aplicação sincronizada pelo ArgoCD
kubectl get pods,svc -n default

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d

## Acessar a interface do ARGOCD
User admin
kubectl port-forward svc/argocd-server -n argocd 8080:443