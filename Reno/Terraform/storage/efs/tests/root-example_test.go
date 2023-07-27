package test

import (
	"fmt"
	"testing"

	aws_sdk "github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/efs"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Create a KMS Key Alias Name
	expectedName := fmt.Sprintf("alias/root-example-%s", random.UniqueId())

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"efs_name": expectedName,
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

	// Return the EFS ID from terraform Outputs
	expectedID := terraform.Output(t, terraformOptions, "efs_id")

	// Create EFS client connection to AWS

	sess, err := aws.NewAuthenticatedSession(awsRegion)

	if err != nil {
		fmt.Printf("Unable to create AWS session: %s", err)
	}

	client := efs.New(sess)

	// Return EFS Nmae
	efsInput := &efs.DescribeFileSystemsInput{
		FileSystemId: aws_sdk.String(expectedID),
	}

	fileSystems, err := client.DescribeFileSystems(efsInput)

	if err != nil {
		fmt.Printf("Unable to return File Systems: %s", err)
	}

	fileSystem := fileSystems.FileSystems[0]

	actualName := *fileSystem.Name

	// Assert the expected and actual names match
	assert.Equal(t, expectedName, actualName)
}
