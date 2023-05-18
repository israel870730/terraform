region          = "us-east-1"
cluster_name    = "eks-poc-test"
cluster_version = "1.22"
vpc_id          = "vpc-01b3f79ec3258feea" //cambiar
tags            = { 
  Name      = "rke-rancher-vpc",
  Env       = "POC",
  Terraform = "true"
}
aws_auth_roles = [
  {
    rolearn  = "arn:aws:iam::114712064551:user/israel.garcia@verifone.com"
    username = "israel.garcia@verifone.com"
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::114712064551:user/Murali_M1@VERIFONE.com"
    username = "Murali_M1@VERIFONE.com"
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::114712064551:user/Ajai.sam@verifone.com"
    username = "Ajai.sam@verifone.com"
    groups   = ["system:masters"]
  },
]