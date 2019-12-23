# Team 2 - Infra
## Team Information

| Name | NEU ID | Email Address | Github username |
| --- | --- | --- | --- |
| Jai Soni| 001822913|soni.j@husky.neu.edu | jai-soni |
| Riddhi Kakadiya| 001811354 | kamlesh.r@husky.neu.edu | riddhiKakadiya |
| Sreerag Mandakathil Sreenath| 001838559| mandakathil.s@husky.neu.edu| sreeragsreenath |
| Vivek Dalal| 001430934 | dalal.vi@husky.neu.edu | vivdalal |

## Technology Stack
Ansible
Kops
kubectl

## Steps to set up Environment

1. create IAM user 'kops' with following permissions
```bash
AmazonEC2FullAccess
AmazonRoute53FullAccess
AmazonS3FullAccess
IAMFullAccess
AmazonVPCFullAccess
```
2. Add user to the user group and create an access key 
3. Set up aws profiles in aws config via
```bash
aws configure --profile <dev/prod>
```

4. Create dev and prod profiles in your local machine. 
Ex: Lets keep common path for these ~/.kops/kopsdevenv, ~/.kops/kopsprodenv. Export the following variable
```bash
export AWS_PROFILE=<dev/prod>
```
5. Activate your aws environment
```bash
source ~/.kops/kopsprodenv 
```
6. We Assume that your ssh public key is named as 'kop_id_rsa.pub'
7. Create a private hosted zone in Route53 and then migrate the NS records to your root account
8. In order to store the state of your cluster, create a dedicated s3 bucket confined to us-east-1 for kops to use 

# Ansible Playbook Commands

## Steps to run Ansible

### To setup the Kubernetes cluster
```bash
ansible-playbook setup-k8s-cluster.yaml -e " \
bucket_name=<bucket_name string> \ 
cluster_name=<cluster_name string> \ 
master_size=<master_size int> \
node_size=<node_size int> \ 
compute_node_count=<node_count int> \ 
dns_zone_id=<zone_id string> \ 
kubernetes_version=<supports < 1.14.6 string> \
ssh_key_name=<ssh_key_name string> \
k8s_cidr_block=10.0.0.0/16 \
region=us-east-1 \
rds_username=<username string eg. root> \
rds_password=<password string> \
"
```

- The following are optional parameters:
```
compute_node_count=<node_count int> 
master_size=<master_size>
node_size=<node_size> 
kubernetes_version=<supports < 1.14.6 string>
```

- Sample command
```
ansible-playbook setup-k8s-cluster.yaml -e " \
bucket_name=dev.csye6225-spring2019-dalalvi.me \
cluster_name=dev.csye6225-spring2019-dalalvi.me \
dns_zone_id=Z1111 \
ssh_key_name=/Users/vivekdalal/.ssh/id_kops_rsa \
k8s_cidr_block=10.0.0.0/16 \
region=us-east-1 \
rds_username=root \
rds_password=Csye2019 \
"
```


- The path to the default parameter yaml file:
```
ansible/roles/setup/default/main.yaml
```

### To teardown the Kubernetes cluster
```bash
ansible-playbook delete-k8s-cluster.yaml -e " \
cluster_name=<cluster_name string> \ 
s3_bucket=<bucket_name string> \ 
region=<aws_region string > \
"
```
- Sample command
```
ansible-playbook delete-k8s-cluster.yaml -e  " \
cluster_name=dev.csye6225-spring2019-dalalvi.me \
s3_bucket=dev.csye6225-spring2019-dalalvi.me \
region=us-east-2 \
"
```

# Testing commands

## Kubectl list nodes
```bash
kubectl get nodes
```

## SSH commands to access Master nodes from Bastian Host
```bash
ssh-add ~/.ssh/<id_kops_rsa>
ssh-add -L
ssh -A admin@bastion{host Url}
ssh admin@{master node IP}
```

## In order to use the kops user for working with AWS RDS Instance, you will have to add the following policy to the kops user

```bash
AmazonRDSFullAccess
```

## Add the following tag to your default VPC. If you dont have a default VPC, please create a VPC manually. This VPC will be used to host the RDS instance
```bash
Tag details:
key > Name
value > default
```

## To ensure the CIDR block for the default VPC and the k8s cluster VPC dont conflict, please pass a different CIDR for the k8s cluster as a CLI parameter.
```bash
k8s_cidr_block=<CIDR_block>
```

example value:
k8s_cidr_block="10.0.0.0/24"

## Please note, the individual roles work as expected. Integrated testing of all roles together is pending.

## To setup the app
```bash
ansible-playbook app-setup.yaml -e " \
docker_username=<docker_username string> \ 
docker_password=<docker_password string> \ 
docker_email=<docker_email string> \
django_profile=<cloud/local> \
s3_bucket_name=<attachment s3 bucket name>\
local_machine=<mac/fedora> \
commit_hash=latest \
"
```

## Sample command to setup app
```bash
ansible-playbook app-setup.yaml -e " \
docker_username=username \
docker_password=password \
docker_email=email \
django_profile=test \
s3_bucket_name=attachments.dev.csye6225-spring2019-dalalvi.me \
local_machine=fedora \
commit_hash=latest \
github_username=github_username \
branch_github=assignment7 \
letsencrypt_email=mandakathil.s@husky.neu.edu \
nginx_domain_name=devapp.csye6225-s19-mandakathils.me \
dns_zone_id=Z35SXDOTRQ7X7K \
"
```

## To delete application
dns_zone_id to be found after creating a sample record in public hosted file

```bash
ansible-playbook app-teardown.yaml    

## set up kubernetes locally
```bash
minikube start
```
```bash
docker login
```
## create secret
```bash
kubectl create secret docker-registry regcred --docker-server=docker.io --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```


## Good examples to check the Dashboard setup
https://kubecloud.io/kubernetes-dashboard-on-arm-with-rbac-61309310a640

https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/


## Command to get the Bearer Token
```bash
kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

#Helm setup

Run the following bash script

```bash
curl -L https://git.io/get_helm.sh | bash
```
Run the playbook with the sample commands shared above.


## Scripts to setup dashboards

Please check the scripts directory for start/stop scripts for Grafana, Prometheus and Kubernetes dashboards. The cluster should be up and running before you run these scripts

## Jenkins password

```bash
printf $(kubectl get secret --namespace jx jx-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
```
## Jenkins port fowarding

kubectl port-forward service/jx-jenkins 8080:8055 --namespace=jx

## To get credentials from pod to set as secrets in Jenkin

```bash
kubectl cp jx/jx-jenkins-ddcbff4d-vgj5t:var/jenkins_home/secrets/hudson.util.Secret ~/hudson.util.Secret 
kubectl cp jx/jx-jenkins-ddcbff4d-vgj5t:var/jenkins_home/secrets/master.key ~/master.key
kubectl cp jx/jx-jenkins-ddcbff4d-vgj5t:var/jenkins_home/credentials.xml ~/credentials.xml
```
