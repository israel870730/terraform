terraform {
  source = "../../../../..//AWS/storage/efs"
}

include {
  path = find_in_parent_folders()
}

inputs = merge(
  yamldecode(file("${find_in_parent_folders("/common/inputs.yaml")}")),
 # yamldecode(run_cmd("--terragrunt-quiet", "${find_in_parent_folders("common/scripts/decrypt.sh")}"))
  yamldecode(file("${find_in_parent_folders("/common/secrets.yaml")}"))
)

dependencies {
  paths = ["../vpc"]
}
