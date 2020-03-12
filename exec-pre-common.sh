#!/usr/bin/env bash
set -o nounset

echo "[aem-helloworld] Executing Custom Manager exec-pre-common step..."
echo "[aem-helloworld] Library: ${AOC_LIBRARY}"
echo "[aem-helloworld] Command: ${AOC_COMMAND}"

RUN_DIR="provisioners/bash/run-puppet.sh"

if [[ "${AOC_LIBRARY}" -eq "aem-aws-stack-builder" ]]; then
  target="$(cut -d' ' -f2 <<<"${AOC_COMMAND}")"
  if [[ "${target}" -eq "switch-dns-consolidated" ]] || [[ "${target}" -eq "switch-dns-full-set" ]]; then
    sh "${RUN_DIR}" "aws_assume_role"
  fi
fi
