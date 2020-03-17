# frozen_string_literal: true

require 'aws-sdk-iam' # v3: require 'aws-sdk'

Puppet::Type.type(:aws_assume_role).provide :ruby, parent: Puppet::Provider do
  def create
    Puppet.debug("Creating IAM role #{name}...")
    @session_name = @resource[:session_name]
    aws_assume_role(@resource[:duration_time], @resource[:region_name],
                    @resource[:policy_document], @resource[:credential_file])
    @property_hash[:ensure] = :present
  end

  def initialize(resource = nil)
    super(resource)
    @session_name = nil
    @assume_resp = nil
    @sts_client = nil
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  # @param [Integer] duration_time :time of the assume
  # session duration in seconds
  # @param [String] region_name :name of the aws region,
  #                 for example :ap-southeast-2, us-east-1, etc.
  # @param [Tuple] assume_doc :array of assume aws policy likes:
  #                            ["s3:ListAllMyBuckets","route53:*"]
  # @param [String] credential_file :path of credentials file.
  def aws_assume_role(duration_time, region_name,
                      assume_doc, credential_file)
    role_arn = fetch_caller_role_arn(region_name)
    create_assume_role(duration_time, assume_doc,
                       role_arn)
    make_credentials_file(credential_file)
  end
end

def fetch_caller_role_arn(region_name)
  # Gather current assigned IAM role arn from caller identity
  Puppet.debug("Gathering credentials...#{region_name}")
  @sts_client = Aws::STS::Client.new(region: region_name)
  sts_resp = @sts_client.get_caller_identity
  role_name = sts_resp.arn.split('/')[1]
  client = Aws::IAM::Client.new(region: region_name)
  iam_resp = client.get_role(role_name: role_name)
  iam_resp.role.arn
end

def create_assume_role(duration_time, assume_doc, role_arn)
  # Create a assume role.
  Puppet.debug('Creating assume role...')
  @assume_resp = @sts_client.assume_role(duration_seconds: duration_time,
                                         policy: assume_doc.to_json,
                                         role_arn: role_arn,
                                         role_session_name: @session_name)
  Puppet.debug(@assume_resp.assumed_role_user.arn)
end

def make_credentials_content
  access_key_id = @assume_resp.credentials.access_key_id
  secret_access_key = @assume_resp.credentials.secret_access_key
  session_token = @assume_resp.credentials.session_token
  expiration = @assume_resp.credentials.expiration
  content_dup = "[#{@session_name}]\n".dup
  content_dup << "aws_access_key_id=#{access_key_id}\n"
  content_dup << "aws_secret_access_key=#{secret_access_key}\n"
  content_dup << "aws_session_token=#{session_token}\n"
  content_dup << "aws_security_token=#{session_token}\n"
  content_dup << "expiration=#{expiration}\n"
end

def make_credentials_file(credential_file)
  # Record its credentials into credentials file.
  Puppet.debug("Record assume credentials in #{credential_file}...")
  content = make_credentials_content
  write_in_file(credential_file, content)
end

def write_in_file(file_path, content)
  File.open(file_path, 'a') do |f|
    f.write content
  end
end
