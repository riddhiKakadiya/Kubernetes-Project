#!/bin/bash
echo "Kubernetes Dashboard Script"
# echo "Applying Dashboard"
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml

# echo "Applying Dashboard Successfully"

# echo "Creating Service Account"
# kubectl create serviceaccount dashboard -n default

# echo "Creating Cluster Binding"
# kubectl create clusterrolebinding dashboard-admin -n default \
#   --clusterrole=cluster-admin \
#   --serviceaccount=default:dashboard

TOKEN=$(kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode)

echo "Token : "

echo $TOKEN

echo "Dashboard can be accessed on : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login"

kubectl proxy