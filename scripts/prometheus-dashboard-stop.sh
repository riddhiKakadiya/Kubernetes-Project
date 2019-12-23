#!/bin/bash

echo "Stopping the Prometheus Dashboard"

prometheus_dashboard_pid=$(pgrep -f prometheus-)

kill -9 $prometheus_dashboard_pid

echo "Successfully killed the Prometheus Dashboard"