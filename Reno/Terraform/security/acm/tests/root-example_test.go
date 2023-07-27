package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	// Set Certificate Domain Name
	certDomainName := "devops.renovite.cloud"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"domain_name": certDomainName,
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

	// Pull the Certificate ARN from Terraform Output
	expectedCertARN := terraform.Output(t, terraformOptions, "cert_arn")

	// Get Certificate ARN
	actualCertARN := aws.GetAcmCertificateArn(t, awsRegion, certDomainName)

	// Ensure expected and actual Certificate ARNs match
	assert.Equal(t, expectedCertARN, actualCertARN)

}
