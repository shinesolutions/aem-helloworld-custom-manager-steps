# Test assume role with route53 policy and check whether get s3 authority.
# Notice: the profile_name may be different which is defined in puppet hiera data file
# The expected result should have route53 list host zone authority,
# and fails on s3 list buckets authority.

require 'aws-sdk-route53' # v3: require 'aws-sdk'
require 'aws-sdk-s3' # v3: require 'aws-sdk'

region_name = "ap-southeast-2"
# Create a credential.
puts "\nCreating assume role credential..."

role_credentials = Aws::SharedCredentials.new(profile_name: "AssumeRoleSession")


# Test a assume role with route53.
puts "\nTest assumed route53 authority..."
client = Aws::Route53::Client.new(region: region_name, credentials: role_credentials)
route53_resp = client.list_hosted_zones_by_name()
puts route53_resp.to_h

# Test a assume role with S3.
puts "\nTest assumed S3 authority..."
client = Aws::S3::Client.new(region: region_name, credentials: role_credentials)
s3_resp = client.list_buckets()
puts s3_resp.to_h
