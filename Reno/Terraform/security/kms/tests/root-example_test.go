package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Create a KMS Key Alias Name
	expectedAliasName := fmt.Sprintf("alias/root-example-%s", random.UniqueId())

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"alias_name": expectedAliasName,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Return the KMS ARN and ID from terraform Outputs
	expectedKeyARN := terraform.Output(t, terraformOptions, "key_arn")
	expectedKeyID := terraform.Output(t, terraformOptions, "key_id")

	// Return the KMS ARN from AWS
	actualKeyARN := aws.GetCmkArn(t, awsRegion, expectedKeyID)

	// Assert the expected and actual Key ARN matches
	assert.Equal(t, expectedKeyARN, actualKeyARN)
}
