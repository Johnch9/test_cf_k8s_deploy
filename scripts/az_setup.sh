#!/bin/bash -e

CLIENT_ID="${AZ_CLIENT_ID:-}"
CLIENT_SECRET="${AZ_CLIENT_SECRET:-}"
SUBSCRIPTION_ID="${AZ_SUBSCRIPTION_ID:-}"
TENANT_ID="${AZ_TENANT_ID:-}"
RESOURCE_GROUP="${AZ_RESOURCE_GROUP:-}"
CLUSTER_NAME="${K8S_NAME:-}"
LOCATION="${AZ_LOCATION:-}"
NODE_COUNT="${AZ_NODE_COUNT:-}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

az login --service-principal -u "${CLIENT_ID}" -p "${CLIENT_SECRET}" --tenant "${TENANT_ID}"

az group create --name "${RESOURCE_GROUP}" --location "${LOCATION}"

SUCCESS="false"
set +e
az aks show \
    -n "${CLUSTER_NAME}" \
    -g "${RESOURCE_GROUP}"
if [[ "$?" == "0" ]]; then
    echo "Cluster already exist"
    SUCCESS="true"
fi
set -e

if [[ "$SUCCESS" != "true" ]]; then
    echo "Cluster does not exist"
    set +e
    az aks create \
        --resource-group "${RESOURCE_GROUP}" \
        --name "${CLUSTER_NAME}" \
        --node-count ${NODE_COUNT} \
        --service-principal "${CLIENT_ID}" \
        --client-secret "${CLIENT_SECRET}" \
        --generate-ssh-keys
    if [[ "$?" == "0" ]]; then
        SUCCESS="true"
    fi
    set -e
fi

ls .

if [[ "$SUCCESS" != "true" ]]; then
    echo "Error exiting"
    exit 1
fi

az aks get-credentials --resource-group "${RESOURCE_GROUP}" --name "${CLUSTER_NAME}" -f kubernetes/kubeconfig.yaml

export KUBECONFIG=kubernetes/kubeconfig.yaml

kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' > kubernetes/kubeca.txt
kubectl config view --raw -o json | jq -r '.clusters[0].cluster."server"' > kubernetes/kubehost.txt

ls kubernetes
cat kubernetes/kubeconfig.yaml
cat kubernetes/kubeca.txt
cat kubernetes/kubehost.txt
