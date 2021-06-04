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





