#!/usr/bin/env bash
set -o nounset

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0} <exec_type>"
  exit 1
fi

BASE_DIR=$(dirname "{$0}")
EXEC_TYPE="{$1}"

# Translate puppet detailed exit codes to basic convention 0 to indicate success.
# More info on Puppet --detailed-exitcodes https://puppet.com/docs/puppet/5.3/man/agent.html
translate_puppet_exit_code() {

  exit_code="$1"

  # 0 (success) and 2 (success with changes) are considered as success.
  # Everything else is considered to be a failure.
  if [ "$exit_code" -eq 0 ] || [ "$exit_code" -eq 2 ]; then
    exit_code=0
  else
    exit "$exit_code"
  fi

  return "$exit_code"
}

set +o errexit

/opt/puppetlabs/bin/puppet apply \
  --detailed-exitcodes \
  --modulepath "${BASE_DIR}"/modules \
  --execute "include aem_helloworld::${EXEC_TYPE}"

translate_puppet_exit_code "$?"

set -o errexit
