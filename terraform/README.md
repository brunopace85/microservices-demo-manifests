Como essa solução funciona:
Deploy da Infraestrutura: O Terraform provisiona a VPC, o EKS, o Elastic IP e o controlador de Load Balancers da AWS.

Instalação do ArgoCD: O Helm instala o ArgoCD no namespace argocd.

Mapeamento GitOps: O recurso kubectl_manifest.argocd_application instrui o ArgoCD a sincronizar continuamente todos os manifestos .yaml localizados no caminho var.github_repo_path do seu repositório no GitHub.

Exposição com IP Fixo: O kubernetes_service.web_app_lb usa as anotações nativas da AWS para direcionar o tráfego que chega no Elastic IP (IP fixo) diretamente para os Pods criados pelo ArgoCD.


terraform init

terraform plan

# Subir primeiro a VPS e o Cluster
terraform apply -target=module.vpc -target=module.eks

terraform apply

Essa abordagem em 2 etapas só é necessária na primeira vez que você provisiona o cluster do zero. A partir da segunda vez, o comando terraform apply funcionará diretamente sem precisar do -target.

terraform output fixed_public_ip

aws eks update-kubeconfig --region us-east-1 --name meu-cluster-eks

# Verifique o ArgoCD
kubectl get pods -n argocd

# Verifique sua aplicação sincronizada pelo ArgoCD
kubectl get pods,svc -n default

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d

# Acessar a interface do ARGOCD
User admin
kubectl port-forward svc/argocd-server -n argocd 8080:443