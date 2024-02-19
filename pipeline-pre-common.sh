#!/usr/bin/env bash
set -o nounset

echo "[aem-helloworld] Executing Custom Manager pipeline-pre-common step..."
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install packer-1.8.6

packer --version
