# Docker revision 

<img src="oci.png">

## Docker build from Git repo 

<img src="gitrepo.png">

## COntainer internal more concepts 

<img src="cont_internal.png">

## Dockerfile more keywords with webapp example 

<img src="webser.png">

## BUilding webapp docker image 

```
 docker  build  -t  httpd:JCI1june2021v1 .
Sending build context to Docker daemon     64kB
Step 1/8 : FROM  fedora
 ---> 055b2e5ebc94
Step 2/8 : LABEL "author.name"="ashutoshh singh"
 ---> Running in 5d9c171adb68
Removing intermediate container 5d9c171adb68
 ---> 44f932710df1
Step 3/8 : LABEL "author.email"="ashutoshh@linux.com"
 ---> Running in 768c34090eac
Removing intermediate container 768c3409

```

### DOcker image build history 

```
 docker  history httpd:JCIashuv1
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
98b7f0d9e2e6   9 minutes ago    /bin/sh -c #(nop)  ENTRYPOINT ["/bin/sh" "-c…   0B        
0257c13c8461   9 minutes ago    /bin/sh -c #(nop)  EXPOSE 80                    0B        
ca77376fb13a   9 minutes ago    /bin/sh -c #(nop) ADD dir:a10de42d8e22bf749b…   57.1kB    
8eb4b25a39c1   11 minutes ago   /bin/sh -c dnf install httpd -y                 248MB     
6aa235133297   12 minutes ago   /bin/sh -c #(nop)  LABEL client=JCI             0B        
3668a0348619   12 minutes ago   /bin/sh -c #(nop)  LABEL author.email=ashuto…   0B        
44f932710df1   12 minutes ago   /bin/sh -c #(nop)  LABEL author.name=ashutos…   0B        
055b2e5ebc94   2 weeks ago      /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B        
<missing>      2 weeks ago      /bin/sh -c #(nop) ADD file:f8b822814d179a767…   178MB     
<missing>      2 months ago     /bin/sh -c #(nop)  ENV DISTTAG=f34container …   0B        
<missing>      2 months ago     /bin/sh -c #(nop)  LABEL maintainer=Clement …   0B  

```

### creating container 

```
 docker run -itd --name ashuwebc1  -p  1234:80  httpd:JCIashuv1
```

### Container port forwarding 

<img src="portf.png">

### image push to docker hub 

```
❯ docker  tag   httpd:JCIashuv1  dockerashu/httpd:JCIashuv1
❯ docker  login -u dockerashu
Password: 
Login Succeeded
❯ docker push dockerashu/httpd:JCIashuv1
The push refers to repository [docker.io/dockerashu/httpd]
c8c0e6699969: Pushed 
f9eaf2c89654: Pushed 
96505a9aeedd: Mounted from library/fedora 
JCIashuv1: digest: sha256:d5cfa9531cc47135d487333db627a9605f1b7be436a0e09dd2e77562a25b8827 size: 951
❯ docker  logout
Removing login credentials for https://index.docker.io/v1/

```

## Container oriented problem for app deploy 

<img src="orch.png">

##  Container orchestraion tools / engine 

<img src="cont_orch.png">

# Kubernetes k8s 

## Level 1 architecutre 

<img src="k8s1.png">

## k8s apiserver 

<img src="apiserver.png">

## kube-schedular 

<img src="kubesche.png">

## Kube-controller-manager 

<img src="kubecm.png">

### node-controller 

<img src="nc.png">

## replication controller 

<img src="rc.png">

## ETCD the brain of k8s 

<img src="etcd.png">

## CNI -- for container networking 

<img src="cni.png">

## Minion kube-proxy + CNI + kubelet 

<img src="minion.png">


