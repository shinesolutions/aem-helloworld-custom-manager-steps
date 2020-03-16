# @summary Generate an aws assume role and record it into a CSV file.
#
# @param [Integer] duration_time :time of the assume session duration in seconds (default: 900-3600).
# @param [String] session_name :name of the session.
# @param [String] region_name :name of the aws region, for example: ap-southeast-2, us-east-1, etc.
# @param [Tuple] assume_policy :array of assume aws policy likes: ["s3:ListAllMyBuckets","route53:*"]
# @param [String] credential_file :path of a credential file.
#
# @example:
#   helloworld::aws_assume_role { 'test':
#     duration_time   => 900,
#     session_name    => "TempSessionRole",
#     region_name     => "ap-southeast-2",
#     assume_policy   => ["s3:*"]
#     credential_file => "/tmp"
#   }
#
class aem_helloworld::create_assume_role (
  $duration_time   = 900, # 15mins
  $session_name    = '',
  $region_name     = '',
  $assume_policy   = '',
  $credential_file = '',
) {

  $assume_doc = {
    'Version'   => '2012-10-17',
    'Statement' => [
      {
        'Effect'   => 'Allow',
        'Action'   => $assume_policy,
        'Resource' => '*'
      }
    ]
  }

  create_assume_role { 'AssumeRole':
    ensure          => present,
    duration_time   => $duration_time,
    session_name    => $session_name,
    region_name     => $region_name,
    credential_file => $credential_file,
    policy_document => $assume_doc
  }
}
