package test

import (
	"fmt"
	"testing"

	aws_sdk "github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/ec2"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Create a Security Group Name
	expectedName := fmt.Sprintf("root-example-%s", random.UniqueId())
	// Set validations for security group rules
	expectedNumberIngressRules := 4
	expectedNumberEgressRules := 4

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name": expectedName,
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

	// Return the Subnet Group ID from the terraform output
	securityGroupID := terraform.Output(t, terraformOptions, "security_group_id")

	// Create a client connection to AWS EC2
	client, err := aws.NewEc2ClientE(t, awsRegion)

	if err != nil {
		fmt.Println("Unable to create EC2 Client", err.Error())
	}

	// Return the Security Group ID from terraform

	// Return the Security Group Object from AWS
	securityGroupInput := &ec2.DescribeSecurityGroupsInput{
		GroupIds: []*string{
			aws_sdk.String(securityGroupID),
		},
	}

	securityGroups, err := client.DescribeSecurityGroups(securityGroupInput)

	if err != nil {
		fmt.Println("Unable to get Security Groups", err.Error())
	}

	securityGroup := securityGroups.SecurityGroups[0]

	// Return the actual security group name
	actualName := *securityGroup.GroupName

	// Ensure the correct name was returned for the Secuirty Group
	assert.Equal(t, expectedName, actualName)

	// Return the number of egress rules set in Security Group
	actualNumberEgressRules := len(securityGroup.IpPermissionsEgress)

	// Ensure the correct number of egress rules were created
	assert.Equal(t, expectedNumberEgressRules, actualNumberEgressRules)

	// Return the number of ingress rules set in Security Group
	actualNumberIngressRules := len(securityGroup.IpPermissions)

	// Ensure the correct number of ingress rules were created
	assert.Equal(t, expectedNumberIngressRules, actualNumberIngressRules)

}
