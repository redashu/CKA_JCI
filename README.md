# Summary of container & orchestration 

<img src="sum.png">

## cleaning up namespace  data

```
❯ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   ashu-jci
          minikube                      minikube     minikube           default
❯ kubectl  get  po
NAME              READY   STATUS    RESTARTS   AGE
ashurc123-4mh6x   1/1     Running   1          17h
ashurc123-kcchh   1/1     Running   1          17h
ashurc123-qwf29   1/1     Running   1          17h
❯ kubectl  get  all
NAME                  READY   STATUS    RESTARTS   AGE
pod/ashurc123-4mh6x   1/1     Running   1          17h
pod/ashurc123-kcchh   1/1     Running   1          17h
pod/ashurc123-qwf29   1/1     Running   1          17h

NAME                              DESIRED   CURRENT   READY   AGE
replicationcontroller/ashurc123   3         3         3       18h

NAME          TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
service/ss1   NodePort   10.96.223.6   <none>        1234:31669/TCP   17h
❯ kubectl  delete all --all
pod "ashurc123-4mh6x" deleted
pod "ashurc123-kcchh" deleted
pod "ashurc123-qwf29" deleted
replicationcontroller "ashurc123" deleted
service "ss1" deleted


```

## Getting started with Deployment 

### creating yaml file 

```
❯ kubectl  create  deployment   ashuwebapp  --image=dockerashu/httpd:jcimultiappv1 --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: ashuwebapp
  name: ashuwebapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ashuwebapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: ashuwebapp
    spec:
      containers:
      - image: dockerashu/httpd:jcimultiappv1
        name: httpd
        resources: {}
status: {}
❯ kubectl  create  deployment   ashuwebapp  --image=dockerashu/httpd:jcimultiappv1 --dry-run=client -o yaml  >ashudep.yml

```

## Deployment deploy

```
❯ ls
aa.json          ashudep.yml      autopod.yaml     customerapp2.yml mypod.yml
ashu-rc1.yaml    ashupod1.yaml    customerapp1.yml deploy.yml       svc1.yaml
❯ kubectl  get  deployments
No resources found in ashu-jci namespace.
❯ kubectl  get  deploy
No resources found in ashu-jci namespace.
❯ kubectl  apply -f  ashudep.yml
deployment.apps/ashuwebapp created
❯ kubectl  get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           5s
❯ kubectl  get  rs
NAME                    DESIRED   CURRENT   READY   AGE
ashuwebapp-5cfc9f66c9   1         1         1       10s
❯ kubectl  get  po
NAME                          READY   STATUS    RESTARTS   AGE
ashuwebapp-5cfc9f66c9-x45xp   1/1     Running   0          13s

```

## rechecking 

```
❯ kubectl  get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           4m27s
❯ kubectl  get   rs
NAME                    DESIRED   CURRENT   READY   AGE
ashuwebapp-5cfc9f66c9   1         1         1       4m42s
❯ kubectl  get   po
NAME                          READY   STATUS    RESTARTS   AGE
ashuwebapp-5cfc9f66c9-x45xp   1/1     Running   0          4m48s
❯ kubectl  get   po -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP               NODE                            NOMINATED NODE   READINESS GATES
ashuwebapp-5cfc9f66c9-x45xp   1/1     Running   0          4m51s   192.168.249.75   ip-172-31-41-131.ec2.internal   <none>           <none>
❯ kubectl get  no
NAME                            STATUS   ROLES                  AGE   VERSION
ip-172-31-34-76.ec2.internal    Ready    <none>                 42h   v1.21.1
ip-172-31-37-20.ec2.internal    Ready    <none>                 42h   v1.21.1
ip-172-31-41-131.ec2.internal   Ready    <none>                 42h   v1.21.1
ip-172-31-41-71.ec2.internal    Ready    control-plane,master   42h   v1.21.1


```

## service creation tips 

<img src="svctips.png">


### creating expose based service 

```
kubectl  expose deployment  ashuwebapp  --type NodePort --port 80 --namespace=ashu-jci  --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    x: ashuwebapp
  name: ashuwebapp
  namespace: ashu-jci
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: ashuwebapp
  type: NodePort
status:
  loadBalancer: {}

```

## redeploy yaml 

```
❯ kubectl  apply -f  ashudep.yml
deployment.apps/ashuwebapp configured
service/ashuwebapp created
❯ kubectl  get  svc
NAME         TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ashuwebapp   NodePort   10.101.75.228   <none>        80:32312/TCP   8s

```

## checking details of deployment like  revision number 

```
❯ kubectl  get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           27m
❯ kubectl  describe  deploy ashuwebapp
Name:                   ashuwebapp
Namespace:              ashu-jci
CreationTimestamp:      Thu, 03 Jun 2021 09:39:25 +0530
Labels:                 x=ashuwebapp
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=ashuwebapp
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=ashuwebapp
  Containers:
   httpd:
    Image:      dockerashu/httpd:jcimultiappv1
    Port:       <none>
    Host Port:  <none>
    Environment:

```

### scaling pod 

```
❯ kubectl  get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           30m
❯ kubectl   scale deployment  ashuwebapp  --replicas=3
deployment.apps/ashuwebapp scaled
❯ kubectl  get  deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   3/3     3            3           30m
❯ kubectl  get  po
NAME                          READY   STATUS    RESTARTS   AGE
ashuwebapp-5cfc9f66c9-n79kk   1/1     Running   0          8s
ashuwebapp-5cfc9f66c9-x45xp   1/1     Running   0          30m
ashuwebapp-5cfc9f66c9-zjgm6   1/1     Running   0          8s

```

## updating image in existing deployment 

```
 kubectl  set  image  deployment   ashuwebapp  httpd=dockerashu/httpd:jcimultiappv2
deployment.apps/ashuwebapp image updated

```

### deployment history 

```
0106  kubectl  describe deploy ashuwebapp  
10107  history
10108  kubectl  describe deploy ashuwebapp  
10109* kubectl  set  image  deployment   ashuwebapp  httpd=dockerashu/httpd:jcimultiappv2 
10110  kubectl  get  deploy 
10111  kubectl  get  po
10112  kubectl  describe deploy ashuwebapp  

```

## History and current revesion number 

```
❯ kubectl  rollout history deployment   ashuwebapp
deployment.apps/ashuwebapp 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

❯ kubectl  describe deploy ashuwebapp
Name:                   ashuwebapp
Namespace:              ashu-jci
CreationTimestamp:      Thu, 03 Jun 2021 09:39:25 +0530
Labels:                 x=ashuwebapp
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               app=ashuwebapp

```

### rolling back by using revision number -- 

## Note: you can also set image to roll back 

```
❯ kubectl  rollout undo deployment   ashuwebapp --to-revision=1
deployment.apps/ashuwebapp rolled back
❯ kubectl  get  po
NAME                          READY   STATUS        RESTARTS   AGE
ashuwebapp-5cfc9f66c9-p65zx   1/1     Running       0          17s
ashuwebapp-5cfc9f66c9-r4ndb   1/1     Running       0          20s
ashuwebapp-5cfc9f66c9-rxq8b   1/1     Running       0          22s
ashuwebapp-75dcd5c7b6-h2g7b   1/1     Terminating   0          5m29s
ashuwebapp-75dcd5c7b6-lbdq6   1/1     Terminating   0          5m27s
ashuwebapp-75dcd5c7b6-vvpgc   1/1     Terminating   0          5m25s

```





