module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"

  eks_cluster_id    = module.eks_blueprints.eks_cluster_id

  # EKS Add-ons
  # Self-managed Add-ons
  
  enable_aws_efs_csi_driver = true
  # # Optional aws_efs_csi_driver_helm_config
  aws_efs_csi_driver_helm_config = {
    description = "The AWS EFS CSI driver Helm chart deployment configuration"
    repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
    version    = "2.4.0"
    namespace  = "kube-system"
  }

  enable_amazon_eks_aws_ebs_csi_driver = true
  # self_managed_aws_ebs_csi_driver_helm_config  = {
  #   description = "The AWS EBS CSI driver Helm chart deployment configuration"
  #   namespace  = "kube-system"
  # }
  enable_aws_load_balancer_controller = true
  enable_aws_cloudwatch_metrics = true
  aws_cloudwatch_metrics_helm_config = {
    description = "The AWS CloudWatch Metrics Helm chart deployment configuration"
    namespace  = "kube-system"
  }
  enable_aws_for_fluentbit = true
  aws_for_fluentbit_helm_config = {
    description = "The Fluentbit Helm chart deployment configuration"
    namespace  = "kube-system"
  }
  enable_metrics_server = true
  enable_cluster_autoscaler = true
  enable_kube_prometheus_stack = true
  kube_prometheus_stack_helm_config = {
    description = "The Prometheus Stack Helm chart deployment configuration"
    namespace  = "prometheus-stack"
  }
  enable_kubernetes_dashboard = true
  kubernetes_dashboard_helm_config = {
    description = "The Kubernetes Dashboard Helm chart deployment configuration"
    namespace  = "kube-system"
  }
  #enable_kubecost = true
  #enable_argocd = true
  #argocd_manage_add_ons = true
  #argocd_helm_config = true
  #enable_argo_rollouts = true
  #enable_aws_node_termination_handler = true
  #enable_secrets_store_csi_driver = true
  #enable_secrets_store_csi_driver_provider_aws = true

}

provider "helm" {
  kubernetes {
    host                   = module.eks_blueprints.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks_blueprints.eks_cluster_id]
    }
  }
}

