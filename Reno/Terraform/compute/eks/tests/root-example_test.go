package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestRootExample(t *testing.T) {
	workingDir := "../examples/root-example"
	clusterName := fmt.Sprintf("root-example-%s", random.UniqueId())
	test_structure.SaveString(t, workingDir, "clusterName", clusterName)

	// At the end of the test, undeploy the web app using Terraform
	defer test_structure.RunTestStage(t, "cleanup_terraform", func() {
		destroyCluster(t, workingDir)
	})

	test_structure.RunTestStage(t, "create eks cluster", func() {
		// Pick a random AWS region to test in. This helps ensure your code works in all regions.
		// awsRegion := aws.GetRandomStableRegion(t, nil, nil)
		awsRegion := "eu-north-1"
		test_structure.SaveString(t, workingDir, "awsRegion", awsRegion)
		buildCluster(t, awsRegion, clusterName, workingDir)
	})

	test_structure.RunTestStage(t, "validate all cluster nodes are ready", func() {
		validateClusterReady(t, clusterName, workingDir)
	})

}

func buildCluster(t *testing.T, awsRegion string, clusterName string, workingDir string) {

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: workingDir,
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"cluster_name": clusterName,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	// Save the Terraform Options struct, instance name, and instance text so future test stages can use it
	test_structure.SaveTerraformOptions(t, workingDir, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

}

func destroyCluster(t *testing.T, workingDir string) {
	// Load the Terraform Options saved by the earlier deploy_terraform stage
	terraformOptions := test_structure.LoadTerraformOptions(t, workingDir)

	terraform.Destroy(t, terraformOptions)
}

func validateClusterReady(t *testing.T, clusterName string, workingDir string) {
	nodesReadyRetries := 20
	nodesReadySleepInterval := time.Duration(5 * time.Second)
	kubeConfigpath := fmt.Sprintf("%s/kubeconfig_%s", workingDir, clusterName)

	options := k8s.NewKubectlOptions("", kubeConfigpath)

	k8s.WaitUntilAllNodesReady(t, options, nodesReadyRetries, nodesReadySleepInterval)

}
