#!/usr/bin/env bash
set -o nounset

echo "[aem-helloworld] Executing Custom Manager exec-pre-common step..."
echo "[aem-helloworld] Library: ${AOC_LIBRARY}"
echo "[aem-helloworld] Command: ${AOC_COMMAND}"

RUN_DIR="provisioners/bash/run-puppet.sh"

if [[ "${AOC_LIBRARY}" == "aem-aws-stack-builder" ]]; then
  if [[ "${AOC_COMMAND}" =~ .*"switch-dns-".* ]]; then
    source "${RUN_DIR}" "aws_assume_role"
  fi
fi
