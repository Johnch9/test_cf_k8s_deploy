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

cd terraform_helm/

echo ${CLIENT_ID}
echo ${TENANT_ID}
echo $DIR
echo $KUBECONFIG

# export KUBECONFIG="$DIR/../kubernetes/kubeconfig.yaml"

cat $KUBECONFIG

ls

terraform init

# terraform plan \
#   -var "client_id=${CLIENT_ID}" \
#   -var "client_secret=${CLIENT_SECRET}" \
#   -var "subscription_id=${SUBSCRIPTION_ID}" \
#   -var "tenant_id=${TENANT_ID}" \
#   -var "location=${LOCATION}" \
#   -var "resource_group_name=${RESOURCE_GROUP}" \
#   -var "cluster_name=${CLUSTER_NAME}" \
#   -var "kube_config_path=${KUBECONFIG}" \
#   .

# export TF_LOG="DEBUG"

set +e
SUCCESS="false"
terraform apply -auto-approve \
  -var "client_id=${CLIENT_ID}" \
  -var "client_secret=${CLIENT_SECRET}" \
  -var "subscription_id=${SUBSCRIPTION_ID}" \
  -var "tenant_id=${TENANT_ID}" \
  -var "location=${LOCATION}" \
  -var "resource_group_name=${RESOURCE_GROUP}" \
  -var "cluster_name=${CLUSTER_NAME}" \
  -var "kube_config_path=${KUBECONFIG}" \
  .
if [[ "$?" == "0" ]]; then
  SUCCESS="true"
fi
set -e

if [[ "$SUCCESS" != "true" ]]; then
    exit 1
fi
