#!/bin/bash -e

CLIENT_ID="${AZ_CLIENT_ID:-}"
CLIENT_SECRET="${AZ_CLIENT_SECRET:-}"
SUBSCRIPTION_ID="${AZ_SUBSCRIPTION_ID:-}"
TENANT_ID="${AZ_TENANT_ID:-}"
LOCATION="${AZ_LOCATION:-}"
RESOURCE_GROUP="${AZ_RESOURCE_GROUP:-}"
CLUSTER_NAME="${K8S_NAME:-}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

cd terraform/

terraform init

# try 3 times in case we are stuck waiting for AKS cluster to come up
set +e
N=0
SUCCESS="false"
until [ $N -ge 3 ]; do
  terraform apply -auto-approve \
    -var "client_id=${CLIENT_ID}" \
    -var "client_secret=${CLIENT_SECRET}" \
    -var "subscription_id=${SUBSCRIPTION_ID}" \
    -var "tenant_id=${TENANT_ID}" \
    -var "location=${LOCATION}" \
    -var "resource_group_name=${RESOURCE_GROUP}" \
    -var "cluster_name=${CLUSTER_NAME}" \
    .
  if [[ "$?" == "0" ]]; then
    SUCCESS="true"
    break
  fi
  N=$[$N+1]
done
set -e

if [[ "$SUCCESS" != "true" ]]; then
    exit 1
fi

terraform output cluster_ca_certificate > ../kubernetes/kubeca.txt
terraform output host > ../kubernetes/kubehost.txt
terraform output kube_config > ../kubernetes/kubeconfig.yaml
