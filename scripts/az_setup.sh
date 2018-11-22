#!/bin/bash -e

CLIENT_ID="${AZ_CLIENT_ID:-}"
CLIENT_SECRET="${AZ_CLIENT_SECRET:-}"
SUBSCRIPTION_ID="${AZ_SUBSCRIPTION_ID:-}"
TENANT_ID="${AZ_TENANT_ID:-}"
RESOURCE_GROUP="${AZ_RESOURCE_GROUP:-}"
CLUSTER_NAME="${AZ_CLUSTER_NAME:-}"
LOCATION="${AZ_LOCATION:-}"
NODE_COUNT="${AZ_NODE_COUNT:-}"


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

az login --service-principal -u "${CLIENT_ID}" -p "${CLIENT_SECRET}" --tenant "${TENANT_ID}"

# az group create --name "${RESOURCE_GROUP}" --location "${LOCATION}"

# # try 3 times in case we are stuck waiting for AKS cluster to come up
# set +e
# N=0
# SUCCESS="false"
# until [ $N -ge 3 ]; do
#   az aks create \
#     --resource-group "${RESOURCE_GROUP}" \
#     --name "${CLUSTER_NAME}" \
#     --node-count ${NODE_COUNT} \
#     --service-principal "${CLIENT_ID}" \
#     --client-secret "${CLIENT_SECRET}" \
#     --generate-ssh-keys
#   if [[ "$?" == "0" ]]; then
#     SUCCESS="true"
#     break
#   fi
#   N=$[$N+1]
# done
# set -e

SUCCESS="true"

ls .

if [[ "$SUCCESS" != "true" ]]; then
    exit 1
fi

az aks get-credentials --resource-group "${RESOURCE_GROUP}" --name "${CLUSTER_NAME}" > kubernetes/kubeconfig.yaml

export KUBECONFIG=kubernetes/kubeconfig.yaml

# kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' | base64 --decode > ../kubernetes/kubeca.txt
# kubectl config view --raw -o json | jq -r '.clusters[0].cluster."server"' > ../kubernetes/kubehost.txt
kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' | base64 -d > kubernetes/kubeca.txt
kubectl config view --raw -o json | jq -r '.clusters[0].cluster."server"' > kubernetes/kubehost.txt

ls kubernetes
