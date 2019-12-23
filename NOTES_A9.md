## Command to check if metrics server is set up right
```bash
kubectl get apiservice v1beta1.metrics.k8s.io -o yaml
```
Should return:
```yaml
apiVersion: apiregistration.k8s.io/v1
kind: APIService
metadata:
  creationTimestamp: "2019-11-13T21:37:20Z"
  labels:
    app: metrics-server
    chart: metrics-server-2.8.8
    heritage: Tiller
    release: metrics-server
  name: v1beta1.metrics.k8s.io
  resourceVersion: "4426"
  selfLink: /apis/apiregistration.k8s.io/v1/apiservices/v1beta1.metrics.k8s.io
  uid: c582b5fc-065d-11ea-87e5-12dcf17fff67
spec:
  group: metrics.k8s.io
  groupPriorityMinimum: 100
  insecureSkipTLSVerify: true
  service:
    name: metrics-server
    namespace: default
  version: v1beta1
  versionPriority: 100
status:
  conditions:
  - lastTransitionTime: "2019-11-13T21:37:46Z"
    message: all checks passed
    reason: Passed
    status: "True"
    type: Available
```

## Command to install and overload servers
```bash
kubectl run -i --tty load-generator --image=busybox /bin/sh
```
kubectl attach load-generator-7fbcc7489f-ttbwf -c load-generator -i -t

Once inside the server, run the following command to overload the service
```bash
while true; do wget -q -O - http://api-service.api.svc.cluster.local:8001/; done
```
or
```bash
while true; do wget -q -O - https://devapp.csye6225-spring2019-kamleshr.me/; done
```

## Command to check if the pod have scaled
```bash
kubectl get hpa -n api
```

## Install yq
https://mikefarah.github.io/yq/

On MacOS
```bash
brew install yq
```

On Ubuntu 16.04 or higher from Debian package:
```bash
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update
sudo apt install yq -y
```

