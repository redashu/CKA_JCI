# Intro to app 

<img src="app.png">


## app deploy history 

<img src="apphist.png">

## hypervisor based OS problems 

<img src="vmprob.png">

## list of CRE 

<img src="cre.png">

## Introduction to Docker 

<img src="docker.png">

## DOcker Desktop introduction 

<img src="dockerdd.png">

## Docker  architecture 

<img src="darch.png">

## checking docker client side 

```
❯ docker  version
Client:
 Cloud integration: 1.0.14
 Version:           20.10.6
 API version:       1.41
 Go version:        go1.16.3
 Git commit:        370c289
 Built:             Fri Apr  9 22:46:57 2021
 OS/Arch:           darwin/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.6
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15


```


## Installing docker Ce --Engine on Linux 

[EngineDOcker](https://docs.docker.com/engine/install/)

### Installing in Linux vm (amazon linux)

```
[root@ip-172-31-47-111 ~]# yum  install  docker  -y
Failed to set locale, defaulting to C
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
amzn2-core                                                                                | 3.7 kB  00:00:00     
Resolving Dependencies
--> Running transaction check
---> Package docker.x86_64 0:20.10.4-1.amzn2 will be installed
--> Processing Dependency: runc >= 1.0.0 for package: docker-20.10.4-1.amzn2.x86_64
--> Processing Dependency: lib

```

## COnfiguring user on docker engine 

```
[root@ip-172-31-47-111 ~]# usermod  -aG  docker  test 
[root@ip-172-31-47-111 ~]# 
[root@ip-172-31-47-111 ~]# 
[root@ip-172-31-47-111 ~]# systemctl start  docker 
[root@ip-172-31-47-111 ~]# systemctl enable   docker 
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
[root@ip-172-31-47-111 ~]# systemctl status  docker 
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2021-05-31 06:15:28 UTC; 10s ago
     Docs: https://docs.docker.com
 Main PID: 3725 (dockerd)
   CGroup: /system.slice/docker.service
           └─3725 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --default-ulimit nofile=1024:4096

May 31 06:15:27 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:27.561750924Z" level=info msg="scheme...grpc
May 31 06:15:27 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:27.561765235Z" level=info msg="ccReso...grpc
May 31 06:15:27 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:27.561772885Z" level=info msg="Client...grpc
May 31 06:15:27 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:27.630077738Z" level=info msg="Loadin...rt."
May 31 06:15:27 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:27.885151055Z" level=info msg="Defaul...ess"
May 31 06:15:28 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:28.062152573Z" level=info msg="Loadin...ne."
May 31 06:15:28 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:28.166060958Z" level=info msg="Docker...10.4
May 31 06:15:28 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:28.166836232Z" level=info msg="Daemon...ion"
May 31 06:15:28 ip-172-31-47-111.ec2.internal systemd[1]: Started Docker Application Container Engine.
May 31 06:15:28 ip-172-31-47-111.ec2.internal dockerd[3725]: time="2021-05-31T06:15:28.188688545Z" level=info msg="API li...ock"
Hint: Some lines were ellipsized, use -l to show in full.


```



## Now time for connecting Docker client to Docker engine using secure ssh keybased connection 

### Mac client generating key pair 

```
❯ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/fire/.ssh/id_rsa): 
/Users/fire/.ssh/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/fire/.ssh/id_rsa.
Your public key has been saved in /Users/fire/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:hdIEmN/LOiYFsXFB3gL6AxJyB1yTBXJRTenMqkqglhY fire@ashutoshhs-MacBook-Air.local
The key's randomart image is:
+---[RSA 3072]----+
|o.+oOX*=o.       |
|.o.=*+.+o.       |
|. o  *+=+ .      |
| . oo .o=.       |
|.E  o. oS.       |
|..o  .o o        |
|.+.  o .         |
|o.  o +          |
|  .. o .         |
+----[SHA256]-----+

```

### same method in windows 10 using gitbash 

### Sending public key to test user in remote linux 

```
 ssh-copy-id   test@54.224.54.156
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/Users/fire/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
test@54.224.54.156's password: 
/etc/profile.d/lang.sh: line 19: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory

Number of key(s) added:        1

Now try logging into the machine, with:   "ssh 'test@54.224.54.156'"
and check to make sure that only the key(s) you wanted were added.


```

## Now testing password less connection from client machine 

```
❯ ssh  test@54.224.54.156
Last login: Mon May 31 05:57:21 2021 from 103.133.168.14

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[test@ip-172-31-47-111 ~]$ 
[test@ip-172-31-47-111 ~]$ 
[test@ip-172-31-47-111 ~]$ exit
logout
Connection to 54.224.54.156 closed.

```

### creating context for remote docker engine 

```
❯ docker  context   ls
NAME                TYPE                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                         ORCHESTRATOR
default *           moby                Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://3.230.225.157:6443 (ashuproject1)   swarm
❯ 
❯ docker  context  create  JciRDE   --docker  host="ssh://test@54.224.54.156"
JciRDE
Successfully created context "JciRDE"
❯ docker  context   ls
NAME                TYPE                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                         ORCHESTRATOR
JciRDE              moby                                                          ssh://test@54.224.54.156                                                  
default *           moby                Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://3.230.225.157:6443 (ashuproject1)   swarm


```




