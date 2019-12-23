# KOPS Commands

## Sample Environment setup
Lets keep common path for this ~/.kops/kopsdevenv, ~/.kops/kopsprodenv
```bash
export AWS_PROFILE=<dev/prod>
export NAME=<CLUSTER_NAME>
export KOPS_STATE_STORE=s3://<YOUR_BUCKET_NAME>
export SSH_KEY=<PATH_TO_YOUR_SSH_PUBLIC_KEY>
export PRIVATE_DNS_ZONE=<YOUR_HOSTED_ZONE_ID>
```
Example export statements. To be removed
```bash
export AWS_PROFILE=dev
export NAME=dev.csye6225-spring2019-dalalvi.me
export KOPS_STATE_STORE=s3://dev.csye6225-spring2019-dalalvi.me
export SSH_KEY=/Users/vivekdalal/.ssh/id_kops_rsa.pub
export PRIVATE_DNS_ZONE=ZABCDEFG
```

## kops commands

- Create the cluster config
```bash
kops create cluster \
--kubernetes-version ${kubernetes_version} \
--node-count=${compute_node_count} \
--master-count=${master_node_count} \
--master-size=${master_size} \
--node-size=${node_size} \
--state=s3://${bucket_name} \
--ssh-public-key=${ssh_public_key} \
--bastion $NAME
```
- Create the cluster
```bash
kops update cluster ${NAME} --yes
```
- Delete kops cluster
```bash
kops delete cluster --name ${NAME} --yes
```

## Notes printed on creation of cluster
- validate cluster: kops validate cluster
- list nodes: kubectl get nodes --show-labels
- ssh to the master: ssh -i ~/.ssh/id_rsa admin@api.dev.csye6225-s19-mandakathils.me
- the admin user is specific to Debian. If not using Debian please use the appropriate user based on your OS.
- read about installing addons at: https://github.com/kubernetes/kops/blob/master/docs/addons.md.
- kubectl get nodes

# Info Links
1. Private hosted Zones
	- https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zones-private.html

2. Create custom ssh keys
	- https://confluence.atlassian.com/bitbucketserver/creating-ssh-keys-776639788.html
3. Nat Gateway
	- https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html

4. Bastion Node
	- https://en.wikipedia.org/wiki/Bastion_host#targetText=A%20bastion%20host%20is%20a,the%20threat%20to%20the%20computer.
	- https://en.wikipedia.org/wiki/Bastion_host#targetText=A%20bastion%20host%20is%20a,the%20threat%20to%20the%20computer.


# Command to setup directory structure - Run it inside the /ansible/roles folder
export dir_name=rds-setup && mkdir -p $dir_name/{tasks,handlers,templates,files,vars,defaults,meta} && touch $dir_name/{tasks,handlers,templates,vars,defaults,meta}/main.yaml && touch $dir_name/files/.gitkeep && touch $dir_name/README.md

# KOPS and Kuberneties 
https://github.com/kubernetes/kops/releases

# Bastian host ssh command
```bash
aws elb --output=table describe-load-balancers|grep DNSName.\*bastion|awk '{print $4}'
ssh -i /home/sreeragsreenath/.ssh/id_kops_rsa admin@bastion-dev-csye6225-s19--50ksvl-117246961.us-east-1.elb.amazonaws.com

```

# SSH into master nodes from Bastian Host
```bash
ssh-add ~/.ssh/id_kops_rsa
ssh-add -L
ssh -A admin@bastion{host Url}
ssh admin@{master node IP}
```

# Elastic search deploy notes:

https://medium.appbase.io/deploy-elasticsearch-with-kubernetes-on-aws-in-10-steps-7913b607abda


# Assignment 6

## Steps for minikube test

### Docker login
```bash
docker login
cat ~/.docker/config.json
```

### Kube simulation

```bash
minikube start
```

```bash
minikube dashboard
```

```bash
kubectl apply -f create_namespace.yaml  
```

```bash
kubectl create secret docker-registry regcred --docker-server=docker.io --docker-username=sreeragsreenath --docker-password=<password> --docker-email=sreeragsreenath@gmail.com --namespace=ui or api
```
```bash
kubectl apply -f my-private-reg-pod.yaml

```


### Accessing Namespace
```bash
minikube service -n ui ui
```

```bash
minikube service -n api api-service
```

Pod: A Pod represents processes running on your Cluster. epresents a unit of deployment: a single instance of an application in Kubernetes, which might consist of either a single container or a small number of containers that are tightly coupled and that share resources.
	https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/

replicaSet: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/

make secret: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials

# Good Ansible filters and tags examples:

https://github.com/pgporada/learning-ansible-filters-and-ec2-tags/blob/master/playbook.yml

# RDS instance + Kops + k8s

https://medium.com/@sinha.shashank.1989/automate-rds-aws-kubernetes-cluster-with-kops-and-terraform-84ee72916c43

# Edit Route in Route table Ansible
 https://stackoverflow.com/questions/41130456/how-do-i-add-routes-to-a-vpcs-default-main-route-table-with-ansible-ec2-vpc-rou

# VPC Peering creation, accepting and deletion reference
https://docs.ansible.com/ansible/latest/modules/ec2_vpc_peering_facts_module.html

# Passing Secrets to Pod
https://medium.com/faun/using-kubernetes-secrets-as-environment-variables-5ea3ef7581ef

#Helm
https://github.com/helm/helm
