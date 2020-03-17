# frozen_string_literal: true

# Generate an aws assume role and record it into credentials file in
# which default path is "~/.aws/credentials"
# The input format should be:
#       aws_assume_role(integer, String, String, Tuple, String)
# For example:
#       aws_assume_role(900, "session_name", "region_name",
#       ["assume_policy"], "/home/.aws/credentials")
#

Puppet::Type.newtype(:aws_assume_role) do
  @doc = 'Type representing aws assume IAM role.'

  ensurable

  newparam(:session_name, namevar: true) do
    desc 'The name of the session role to manage.'
  end

  newproperty(:duration_time) do
    desc 'The duration time in seconds to the role.'
    defaultto 900
    validate do |value|
      raise 'Duration time should be a Number' unless value.is_a?(Numeric)
    end
  end

  newproperty(:region_name) do
    desc 'The region name to the role.'
  end

  newproperty(:credential_file) do
    desc 'The generated credentials file to the role.'
  end

  newproperty(:policy_document) do
    desc 'The policy document JSON string'
  end
end
