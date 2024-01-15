package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/iam"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Create a name prefix
	expectedNamePrefix := fmt.Sprintf("root-example-%s", random.UniqueId())
	expectedPolicyName := fmt.Sprintf("%s-iam-policy", expectedNamePrefix)
	expectedRoleName := fmt.Sprintf("%s-iam-role", expectedNamePrefix)
	expectedUserName := fmt.Sprintf("%s-iam-user", expectedNamePrefix)

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	// (global service so probably no needed)
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name_prefix": expectedNamePrefix,
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

	// Get the ARN for Policy, Role & User from Terraform
	expectedPolicyARN := terraform.Output(t, terraformOptions, "policy_arn")
	expectedRoleARN := terraform.Output(t, terraformOptions, "role_arn")
	expectedUserARN := terraform.Output(t, terraformOptions, "user_arn")

	// Create IAM client to AWS
	iamClient, err := aws.NewIamClientE(t, awsRegion)

	if err != nil {
		fmt.Println(err)
	}

	// Return Policy Name
	iamPolicyOutput, err := iamClient.GetPolicy(&iam.GetPolicyInput{PolicyArn: &expectedPolicyARN})
	actualPolicyName := *iamPolicyOutput.Policy.PolicyName

	// Return Role ARN
	iamRoleOutput, err := iamClient.GetRole(&iam.GetRoleInput{RoleName: &expectedRoleName})
	actualRoleARN := *iamRoleOutput.Role.Arn

	// Return User ARN
	iamUserOutput, err := iamClient.GetUser(&iam.GetUserInput{UserName: &expectedUserName})
	actualUserARN := *iamUserOutput.User.Arn

	// Assert expected Name matches actual Name for Policy
	assert.Equal(t, expectedPolicyName, actualPolicyName)

	// Assert expected ARN matches actual ARN for Role & User
	assert.Equal(t, expectedRoleARN, actualRoleARN)
	assert.Equal(t, expectedUserARN, actualUserARN)
}
