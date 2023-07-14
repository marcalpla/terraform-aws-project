#!/bin/bash
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPTPATH
ENV=$(basename $(dirname $(dirname $SCRIPTPATH)))_$(basename $SCRIPTPATH)
echo $PWD
bucket=$(awk '/bucket/ { gsub (/[ "]/, ""); split($0,a,"="); print a[2] }' aws.tf)

echo "Setting Terraform environment for s3://$bucket/terraform/$ENV"

if [ -z "$ENV" ];then
  echo "No valid environment: $ENV"
  exit 1
fi

KEY="key=terraform/${ENV}.tfstate"
rm -fr .terraform/terraform.tfstate && terraform init -input=false -backend-config="key=terraform/${ENV}.tfstate"
echo "$KEY"
