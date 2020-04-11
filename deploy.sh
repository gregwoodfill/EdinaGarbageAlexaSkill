#!/bin/bash
set -euf -o pipefail

./local-build.sh
pushd infrastructure
    terraform init
    terraform plan
    terraform apply -auto-approve
popd