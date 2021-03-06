#!/bin/bash -e

K8S_NAME="${K8S_NAME:-terraform-aks-demo}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

set -o pipefail

DECODE_FLAGS="-d"
if [ "$(uname)" == "Darwin" ]; then
    DECODE_FLAGS="-D"
fi

codefresh get context aks-install-${K8S_NAME} -o json | \
    jq -r '.spec.data.TFSTATE_BASE64' | \
    sed -e 's/^null$$//' | \
    base64 $DECODE_FLAGS > terraform/terraform.tfstate
