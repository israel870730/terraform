# data "aws_route53_zone" "sub" {
#   #name = local.hosted_zone_name
#   name = "deployment.vcsgreenbox.com"
# }

# data "aws_route53_zone" "selected" {
#   name         = var.domain_name
#   private_zone = var.private_zone
# }

module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"

  eks_cluster_id    = module.eks_blueprints.eks_cluster_id

  # EKS Add-ons
  # enable_amazon_eks_aws_ebs_csi_driver = true

  # # Self-managed Add-ons
  # enable_aws_efs_csi_driver = true

  # # Optional aws_efs_csi_driver_helm_config
  # aws_efs_csi_driver_helm_config = {
  #   repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  #   version    = "2.4.0"
  #   namespace  = "kube-system"
  # }

  enable_aws_load_balancer_controller = true
  enable_metrics_server = true
  enable_kube_prometheus_stack = true
  enable_argocd = true

  ## Optional metrics_server_helm_config
#   metrics_server_helm_config = {
#   }
  # enable_cert_manager   = true
  #cert_manager_route53_hosted_zone_arns  = ["arn:aws:route53:::hostedzone/XXXXXXXXXXXXX"]

  #enable_cluster_autoscaler = true
#   cluster_autoscaler_helm_config = {
#     name        = "cluster-autoscaler"
#     namespace   = "kube-system"
#     description = "Cluster Autoscaler Helm chart deployment configuration"
#   }


  # enable_karpenter = true
  # ## Optional karpenter_helm_config
  # karpenter_helm_config = {
  #   name       = "karpenter"
  #   #namespace  = "kube-system"
  #   chart      = "karpenter"
  #   repository = "oci://public.ecr.aws/karpenter"
  #   version    = "v0.27.0"
  #   namespace  = "karpenter"
  # }

  # enable_aws_cloudwatch_metrics = true
  # ## Optional aws_cloudwatch_metrics_helm_config
  # aws_cloudwatch_metrics_helm_config = {
  #   namespace   = "kube-system"
  #   description = "The AWS CloudWatch Metrics Helm chart deployment configuration"
  # }

  # enable_aws_for_fluentbit = true
  # ## Optional aws_for_fluentbit_helm_config
  # aws_for_fluentbit_helm_config = {
  #   namespace   = "kube-system"
  #   description = "The AWS Fluent-bit Helm chart deployment configuration"
  # }

#   enable_external_dns    = true
#   external_dns_route53_zone_arns      = [data.aws_route53_zone.sub.arn]

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


