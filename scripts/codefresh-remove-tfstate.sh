#!/bin/bash -e

K8S_NAME="${AZ_RESOURCE_GROUP:-terraform-aks-demo}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

codefresh delete context aks-install-${K8S_NAME}
