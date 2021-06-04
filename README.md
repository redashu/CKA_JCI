# Journey 

<img src="bare2cont.png">

## Introduction to microservices 

<img src="micro.png">

## Certification info 

<img src="cert.png">

## Kubernetes service account 

<img src="saa.png">

# RBAC 

<img src="rbac.png">


## Dashboard --

###  default there is no permission in serviceaccount 

```
❯ kubectl  get  po -n kubernetes-dashboard
NAME                                         READY   STATUS    RESTARTS   AGE
dashboard-metrics-scraper-856586f554-dccwc   1/1     Running   1          17h
kubernetes-dashboard-78c79f97b4-ftx4q        1/1     Running   1          17h
❯ kubectl  get  svc -n kubernetes-dashboard
NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
dashboard-metrics-scraper   ClusterIP   10.107.214.55   <none>        8000/TCP        17h
kubernetes-dashboard        NodePort    10.108.33.170   <none>        443:31336/TCP   17h
❯ kubectl  get  sa  -n kubernetes-dashboard
NAME                   SECRETS   AGE
default                1         17h
kubernetes-dashboard   1         17h
❯ kubectl  get  clusterrole   |   grep -i  admin
admin                                                                  2021-06-01T09:41:04Z
cluster-admin                                                          2021-06-01T09:41:04Z
system:aggregate-to-admin                                              2021-06-01T09:41:04Z
system:kubelet-api-admin                                               2021-06-01T09:41:04Z


```

## to access dashboard getting token of serviceaccount 

```
❯ kubectl  get  sa  -n kubernetes-dashboard
NAME                   SECRETS   AGE
default                1         17h
kubernetes-dashboard   1         17h
❯ kubectl  get  secret   -n kubernetes-dashboard
NAME                               TYPE                                  DATA   AGE
default-token-6sdnw                kubernetes.io/service-account-token   3      17h
kubernetes-dashboard-certs         Opaque                                0      17h
kubernetes-dashboard-csrf          Opaque                                1      17h
kubernetes-dashboard-key-holder    Opaque                                2      17h
kubernetes-dashboard-token-kmd4f   kubernetes.io/service-account-token   3      17h

===

```

## getting secret 

```
10105  kubectl  describe  secret   kubernetes-dashboard-token-kmd4f   -n kubernetes-dashboard 
10106  kubectl  get  secret/kubernetes-dashboard-token-kmd4f -o jsonpath='{.data.token}'    -n kubernetes-dashboard 

10109  kubectl  get  secret/kubernetes-dashboard-token-kmd4f -o jsonpath='{.data.token}'    -n kubernetes-dashboard |  base64 -d
❯ kubectl  describe  secret   kubernetes-dashboard-token-kmd4f   -n kubernetes-dashboard
Name:         kubernetes-dashboard-token-kmd4f
Namespace:    kubernetes-dashboard
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: kubernetes-dashboard
              kubernetes.io/service-account.uid: 6b5c1177-b2b9-4f57-a461-089f46e7b5ae

Type:  kubernetes.io/service-account-token

Data
====
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6Ilg0ZXRFdVRxQ1VXajFQZDV3UlVYdk91VnNDWlVqLVBtVk0xQ2pHd3BfbG8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZC10b2tlbi1rbWQ0ZiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjZiNWMxMTc3LWIyYjktNGY1Ny1hNDYxLTA4OWY0NmU3YjVhZSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlc

```

## Binding object 

<img src="bind.png">

## deploy 

```
 kubectl apply -f clusterrolebind.yaml
 
```

### Creating a general user access by custom  -- kubeconfig file 

<img src="access.png">

## every k8s client need api-server certification to establish connection 

<img src="apiserver.png">

## Final view of config file data 

<img src="config.png">

## creating a custom user access config file 

### namespace creation 

```
❯ kubectl   create namespace   java-project
namespace/java-project created
❯ kubectl  get  sa,secret  -n java-project
NAME                     SECRETS   AGE
serviceaccount/default   1         16s

NAME                         TYPE                                  DATA   AGE
secret/default-token-k5862   kubernetes.io/service-account-token   3      16s

```

## Now time for creating role and rolebind then assign to service account 

<img src="rolebb.png">

### creating role 

```
 kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods   --dry-run=client -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: null
  name: pod-reader
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch

```

### role created 

```
❯ kubectl  get  role  -n  java-project
NAME         CREATED AT
pod-reader   2021-06-04T06:39:43Z

```

### now using kubeconfig 

```
❯ kubectl  apply  -f  autopod.yaml  --kubeconfig  ~/Desktop/java.conf
Error from server (Forbidden): error when creating "autopod.yaml": pods is forbidden: User "system:serviceaccount:java-project:default" cannot create resource "pods" in API group "" in the namespace "java-project"
❯ kubectl  apply  -f  autopod.yaml  --kubeconfig  ~/Desktop/java.conf
pod/ashupod2 created


```

##  topics for CKA --- 

<img src="cka.png">


# Auto scaling concept in k8s

<img src="autos.png">

## To add a new minion node in running cluster 

### shell script in new node to be run 

```
#!/bin/bash 

# enable CNI support  driver in linux kernel 
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables


# For installation only disable swap memory 

swapoff  -a

#  configuring repo -- in exam it will be done by examier   

cat  <<EOF  >/etc/yum.repos.d/kube.repo
[kube]
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
gpgcheck=0
EOF

# Install cre  

yum  install docker  -y 
systemctl start docker
systemctl  enable docker  # default docker start at BOot 

# Install kubeadm -- the official installer of Kubernetes cluster in multi node environment 

yum  install kubeadm  -y
# starting agent service 
systemctl  start  kubelet 
systemctl  enable   kubelet 

```


### generating token for minion on master node 

```
kubeadm  token create  --print-join-command 
kubeadm join 172.31.41.71:6443 --token gsn4d4.ohq9jq9siacnqqxf --discovery-token-ca-cert-hash sha256:0db7
```

### Now pasting this in new node 

```
[root@ip-172-31-46-150 ~]# kubeadm join 172.31.41.71:6443 --token gsn4d4.ohq9jq9siacnqqxf --discovery-token-ca-cert-hash sha256:0db76f53fc2033845991b2453df100c14ed3ca4996ff267356668b3232166d87
[preflight] Running pre-flight checks
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
	[WARNING FileExisting-tc]: tc not found in system path
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

```

## pod based auto scaling 

<img src="hpa.png">

### HPA understanding 

<img src="hpa1.png">

### hpa using metrics servers to auto scale the POD 

<img src="flow.png">

### Deploy Metric server in k8s 

[linkgithub](https://github.com/kubernetes-sigs/metrics-server)

```

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

```

### Deploying a web app

```
❯ kubectl  apply -f  hpawebapp.yml  --dry-run=client
deployment.apps/ashuwebapp created (dry run)
❯ kubectl  apply -f  hpawebapp.yml
deployment.apps/ashuwebapp created
❯ kubectl  get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   2/2     2            2           6s
❯ kubectl  get  rs
NAME                    DESIRED   CURRENT   READY   AGE
ashuwebapp-65c7b94c68   2         2         2       13s
❯ kubectl  get  pod
NAME                          READY   STATUS    RESTARTS   AGE
ashuwebapp-65c7b94c68-d8jlb   1/1     Running   0          16s
ashuwebapp-65c7b94c68-tk9bq   1/1     Running   0          16s
❯ kubectl  expose  deployment  ashuwebapp --type NodePort  --port 80
service/ashuwebapp exposed
❯ kubectl  get  svc
NAME         TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ashuwebapp   NodePort   10.108.176.50   <none>        80:31925/TCP   6s

```

## Hpa 

```
10247  kubectl  autoscale  deployment ashuwebapp  --cpu-percent=70   --min=2  --max=30  
10248  kubectl  get  hpa
❯ 
❯ 
❯ kubectl  get  hpa
NAME         REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
ashuwebapp   Deployment/ashuwebapp   0%/70%    2         30        2          88s

```

