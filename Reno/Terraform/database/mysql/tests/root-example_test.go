package test

import (
	"fmt"
	"math/rand"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRootExample(t *testing.T) {
	t.Parallel()

	// Give this RDS Instance a unique ID for a name tag so we can distinguish it from any other RDS Instance running
	// in your AWS account
	expectedName := fmt.Sprintf("root-example-%s", strings.ToLower(random.UniqueId()))
	expectedPort := int64(3306)

	// Pick a random AWS region to test in. This helps ensure your code works in all regions
	// and return a random availibility zone.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	availabilityZones := aws.GetAvailabilityZones(t, awsRegion)
	availabilityZone := availabilityZones[rand.Intn(len(availabilityZones))]

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/root-example",

		// Variables to pass to our Terraform code using -var options
		// "username" and "password" should not be passed from here in a production scenario.
		Vars: map[string]interface{}{
			"availability_zone": availabilityZone,
			"name":              expectedName,
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

	// Run `terraform output` to get the value of an output variable
	dbInstanceID := terraform.Output(t, terraformOptions, "db_instance_id")

	// Look up the endpoint address and port of the RDS instance
	address := aws.GetAddressOfRdsInstance(t, dbInstanceID, awsRegion)
	port := aws.GetPortOfRdsInstance(t, dbInstanceID, awsRegion)

	// Verify that the address is not null
	assert.NotNil(t, address)
	// Verify that the DB instance is listening on the port mentioned
	assert.Equal(t, expectedPort, port)
}
