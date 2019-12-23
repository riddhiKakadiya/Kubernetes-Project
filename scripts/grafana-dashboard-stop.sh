#!/bin/bash

echo "Stopping the Grafana Dashboard"

grafana_dashboard_pid=$(pgrep -f grafana-)

kill -9 $grafana_dashboard_pid

echo "Successfully killed the Grafana Dashboard"