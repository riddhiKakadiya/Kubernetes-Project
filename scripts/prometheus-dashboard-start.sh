#!/bin/bash

echo "Starting Prometheus Dashboard"

echo "Exporting POD_NAME for Prometheus"

POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")

echo "Starting Prometheus in background"
nohup kubectl --namespace monitoring port-forward $POD_NAME 9090 > /dev/null 2>&1 &

echo "Prometheus Dashboard started. Access it on http://localhost:9090"
