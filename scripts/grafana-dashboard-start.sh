#!/bin/bash

echo "Starting Grafana Dashboard"

grafana_password=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" \
 | base64 --decode ; echo)

echo "Grafana Dashboard Username: admin and Password : $grafana_password"

echo "Exporting POD_NAME for Grafana"

POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")

echo "Starting Grafana in background"
nohup kubectl --namespace monitoring port-forward $POD_NAME 3000 > /dev/null 2>&1 &

echo "Grafana Dashboard started. Access it on http://localhost:3000"
