## Setup Instructions for Jenkins
local setup
https://medium.com/containerum/configuring-ci-cd-on-kubernetes-with-jenkins-89eab7234270

how to configure github in jenkins with 2 factor authentication
https://stackoverflow.com/questions/43746923/configure-jenkins-for-github-ci-w-2fa

## JX Commands
jx get env

kubectl exec -ti --namespace=jx jx-jenkins-7ff9dbbf48-98pqz -- /bin/bash
cd /var/jenkins_home/jobs
cat the config file you need

elastic-search chart:

https://github.com/helm/charts/tree/master/stable/elasticsearch-exporter
https://github.com/justwatchcom/elasticsearch_exporter/blob/master/examples/kubernetes/deployment.yml

## Jenkins port fowarding

kubectl port-forward service/jx-jenkins 8055:8080 --namespace=jx

## To get credentials from pod to set as secrets in Jenkin

```bash
kubectl cp jx/jx-jenkins-76554f6f84-zpcr7:var/jenkins_home/secrets/hudson.util.Secret ~/cloud/hudson.util.Secret 
kubectl cp jx/jx-jenkins-76554f6f84-zpcr7:var/jenkins_home/secrets/master.key ~/cloud/master.key
kubectl cp jx/jx-jenkins-76554f6f84-zpcr7:var/jenkins_home/credentials.xml ~/cloud/credentials.xml
```


