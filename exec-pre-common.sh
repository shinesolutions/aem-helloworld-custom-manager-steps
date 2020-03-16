#!/usr/bin/env bash
set -o nounset

echo "[aem-helloworld] Executing Custom Manager exec-pre-common step..."
echo "[aem-helloworld] Library: ${AOC_LIBRARY}"
echo "[aem-helloworld] Command: ${AOC_COMMAND}"

RUN_DIR="script/bash/run-puppet.sh"

# Assume role pre-common logic
if [[ "${AOC_LIBRARY}" == "aem-aws-stack-builder" ]]; then
  if [[ "${AOC_COMMAND}" =~ .*"switch-dns-".* ]]; then
    echo "[aem-helloworld] Executing aws assume role..."
    # shellcheck disable=SC1090
    source "${RUN_DIR}" "create_assume_role"
  fi
fi
