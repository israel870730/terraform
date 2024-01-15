package test

import (
	"fmt"
	"testing"

	"github.com/aws/aws-sdk-go/service/ec2"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Create a VPC name
	expectedName := fmt.Sprintf("root-example-%s", random.UniqueId())
	expectedNumberSubnets := 9
	vpcFilterName := "vpc-id"

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"vpc_name": expectedName,
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

	// Create a client connection to AWS EC2
	client, err := aws.NewEc2ClientE(t, awsRegion)

	if err != nil {
		fmt.Println("Unable to create EC2 Client", err.Error())
	}

	// Return the VPC
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	vpcFilter := ec2.Filter{Name: &vpcFilterName, Values: []*string{&vpcID}}
	vpcs, err := client.DescribeVpcs(&ec2.DescribeVpcsInput{Filters: []*ec2.Filter{&vpcFilter}})

	vpc := vpcs.Vpcs[0]

	// Get the name of the VPC
	actualName := aws.FindVpcName(vpc)

	// Ensure the name returned from AWS matches the Name set by Terraform
	assert.Equal(t, expectedName, actualName)

	// Get the number of subnets contained in the VPC
	actualNumberSubnets := len(aws.GetSubnetsForVpc(t, vpc_id, awsRegion))

	// Ensure the number of subnets returned by AWS matches the expected number
	assert.Equal(t, expectedNumberSubnets, actualNumberSubnets)

}
