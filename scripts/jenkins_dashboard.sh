#!/bin/bash

echo "Generating Jenkins Token"

echo "Username : "

echo "admin"

echo "Password : "

printf $(kubectl get secret --namespace jx jx-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

echo "Starting Jenkins port forwarding at 8055"

echo "Dashboard can be accessed on : http://localhost:8055"

kubectl port-forward service/jx-jenkins 8055:8080 --namespace=jx