include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../..//AWS/network/vpc"
}

inputs = merge(
  yamldecode(file("${find_in_parent_folders("/common/inputs.yaml")}")),
 # yamldecode(run_cmd("--terragrunt-quiet", "${find_in_parent_folders("common/scripts/decrypt.sh")}"))
  yamldecode(file("${find_in_parent_folders("/common/secrets.yaml")}"))
)
