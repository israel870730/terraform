module "cluster_autoscaler_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.3.1"

  role_name                        = "cluster-autoscaler" 
  //role_name                        = "${var.business_divsion}-${var.environment}"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_ids   = [data.terraform_remote_state.eks.outputs.cluster_id]

  oidc_providers = {
    ex = {
      provider_arn               = data.terraform_remote_state.eks.outputs.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
}
