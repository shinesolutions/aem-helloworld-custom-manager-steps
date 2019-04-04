[![Build Status](https://img.shields.io/travis/shinesolutions/aem-helloworld-custom-manager-steps.svg)](http://travis-ci.org/shinesolutions/aem-helloworld-custom-manager-steps)

# AEM Hello World Custom Manager Steps

This is an example AEM OpenCloud Custom Manager Steps artifact that will be set up as one of [AEM OpenCloud Manager customisation points](https://github.com/shinesolutions/aem-aws-stack-builder/blob/master/docs/customisation-points.md#custom-stack-provisioner).

This artifact contains:
* `stage-pre-common.sh` shell script which will be executed before each build stage execution
* `stage-post-common.sh` shell script which will be executed after each build stage execution
* `pipeline-pre-common.sh` shell script which will be executed before each build pipeline execution
* `pipeline-post-common.sh` shell script which will be executed after each build pipeline execution
* `exec-pre-common.sh` shell script which will be executed before each command execution
* `exec-post-common.sh` shell script which will be executed after each command execution

One example use case of these Custom Manager Steps is for authentication. A user might need to retrieve temporary credential from AWS [Security Token Service](https://docs.aws.amazon.com/STS/latest/APIReference/Welcome.html) and this can be done either once per pipeline, once per stage, or once per command execution as a pre step.

## Usage

To create artifact tar.gz file:

    make package

The artifact will be written at `stage/aem-helloworld-custom-manager-steps-<version>.tar.gz`

Publish this artifact to a distribution platform, e.g.: [Artifactory](https://jfrog.com/artifactory/), [Nexus](https://www.sonatype.com/nexus-repository-sonatype), [S3](https://aws.amazon.com/s3/), or any other tool that you use for publishing artifacts.

Set the URL of the above published artifact as the value of [AEM OpenCloud Manager configuration](https://github.com/shinesolutions/aem-opencloud-manager/blob/master/docs/configuration.md) property `aem_opencloud.custom_manager_steps.artifact_url` .
