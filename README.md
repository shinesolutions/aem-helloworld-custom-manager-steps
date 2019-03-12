[![Build Status](https://img.shields.io/travis/shinesolutions/aem-helloworld-custom-manager-steps.svg)](http://travis-ci.org/shinesolutions/aem-helloworld-custom-manager-steps)

# AEM Hello World Custom Manager Steps

This is an example AEM OpenCloud Custom Manager Steps artifact that will be set up as one of [AEM OpenCloud Manager customisation points](https://github.com/shinesolutions/aem-aws-stack-builder/blob/master/docs/customisation-points.md#custom-stack-provisioner).

This artifact contains:
* `stage-pre-common.sh` shell script which will be executed before each build stage execution
* `stage-post-common.sh` shell script which will be executed after each build stage execution
* `pipeline-pre-common.sh` shell script which will be executed before each build pipeline execution
* `pipeline-post-common.sh` shell script which will be executed after each build pipeline execution

## Usage

To create artifact tar.gz file:

    make package

The artifact will be written at `stage/aem-helloworld-custom-manager-steps-<version>.tar.gz`

Publish this artifact to a distribution platform, e.g.: [Artifactory](https://jfrog.com/artifactory/), [Nexus](https://www.sonatype.com/nexus-repository-sonatype), [S3](https://aws.amazon.com/s3/), or any other tool that you use for publishing artifacts.

Set the URL of the above published artifact as the value of [AEM OpenCloud Manager configuration](https://github.com/shinesolutions/aem-opencloud-manager/blob/master/docs/configuration.md) property `aem_opencloud.custom_manager_steps.artifact_url` .
